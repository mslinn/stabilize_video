#!/usr/bin/env ruby

require 'colorator'
require 'fileutils'
require 'optparse'
require 'tempfile'
require_relative 'run'

# Ffmpeg's `deshake` filter can be used for a single-pass shake removal.
# This script does not do that.
# Instead, better results are obtained by running the ffmpeg vidstab library in two passes.
#
# In the first pass, the vidstabdetect filter analysing the video frames and generates a `transforms file`.
# This file contains stabilization data, consisting of translation and rotation transformations.
# By default, the generated transforms file is saved to `transforms.trf`; the `result` option specifies another path.
#
# Options:
#   shakiness: Set the shakiness of input video or quickness of camera.
#              Default value is 5.
#              Value range 1 (little shakiness) to 10 (very shaky).

# The second pass uses `transforms.trf` to produce a stable video output.
# Use ffmpeg's unsharp filter for best results.
# Options:
#
#   smoothing: Set the number of frames used for lowpass filtering the camera movements.
#              Default value: 10.
#              Recommended value: videoFPS / 2
#              The number of frames is computed from (value*2 + 1)
#              For example, a number of 10 means that 21 frames are used (10 previous frames and 10 following frames) to smoothen the video.
#              Larger values lead to smoother videos, but limit the acceleration of the camera (pan/tilt movements).
#
#        zoom: Set percentage to zoom the video.
#              Default value is 0 (no zoom).
#              A positive value results in a zoom-in effect; a negative value results in a zoom-out effect.
#
# Syntax:
# stabilize filename

# Stage 1 (vidstabdetect filter)
# The `-f null -` option tells ffmpeg to suppress the generation of an output video file
# ffmpeg "$INPUT" -vf vidstabdetect $SUPPRESS_OUTPUT

# Analyze strongly shaky video and putting the results in file mytransforms.trf:
# ffmpeg "$INPUT" -vf vidstabdetect=shakiness=10:${TRANSFORM_RESULTS} $SUPPRESS_OUTPUT
# TODO: read from stdin if pipe detected
# TODO: send to stdout if pipe detected
class StablizeVideo
  SUPPRESS_OUTPUT = '-f null -'.freeze

  include Run

  def initialize(video_in, video_out)
    @shake = 5 # Medium shakiness
    @shakiness = "shakiness=#{@shake.clamp(1, 10)}"
    @video_in = video_in
    @video_out = video_out

    @input = "-i #{@video_in}"
  end

  def stabilize
    smooth = compute_smoothing @input
    Tempfile.open('transforms', '/tmp') do |fio|
      analyze_video(@shakiness, fio.path)
      smooth(@input, smooth, fio.path)
    end
  end

  private

  # Analyze a video and store results in temporary file
  def analyze_video(shakiness, path)
    tx_path = "result=#{path}"
    run "ffmpeg #{@input} -vf vidstabdetect=#{shakiness}:#{tx_path} #{SUPPRESS_OUTPUT}"
  end

  # From https://stackoverflow.com/a/72129067
  # Evaluate a string representation of an arithmetic formula provided only these operations are expected:
  #   + | Addition
  #   - | Subtraction
  #   * | Multiplication
  #   / | Division
  #
  # Also assumes only integers are given for numerics.
  # Not designed to handle division by zero.
  #
  # Example input:   '20+10/5-1*2'
  # Expected output: 20.0
  def calculate(string) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    add_split      = string.split('+')
    subtract_split = add_split.map { |v| v.split('-') }
    divide_split   = subtract_split.map do |i|
      i.map { |v| v.split('/') }
    end
    multiply_these = divide_split.map do |i|
      i.map do |j|
        j.map { |v| v.split('*') }
      end
    end

    divide_these = multiply_these.each do |i|
      i.each do |j|
        j.map! do |k, l|
          if l.nil?
            k.to_i
          else
            k.to_i * l.to_i
          end
        end
      end
    end

    subtract_these = divide_these.each do |i|
      i.map! do |j, k|
        if k.nil?
          j.to_i
        else
          j / k.to_f
        end
      end
    end

    add_these = subtract_these.map! do |i, j|
      if j.nil?
        i.to_f
      else
        i.to_f - j.to_f
      end
    end

    add_these.sum
  end

  # Perform stage 1
  # fps / 2 yields smoothing value
  def compute_smoothing(input)
    command = "ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=nw=1:nk=1 #{input}"
    fraction = run_capture_stdout(command).first

    result = calculate "#{fraction}/2"
    "smoothing=#{result.to_i}"
  end

  # Perform stage 2
  def smooth(input, smooth, path)
    # Stage 2 (vidstabtransform filter)
    tx_path = "input=#{path}"
    run "ffmpeg #{input} -vf vidstabtransform=#{smooth}:zoom=5:#{tx_path} #{@video_out}"
  end
end
