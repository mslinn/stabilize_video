require 'colorator'
require_relative 'stabilize_video/version'
require_relative 'options'

# Require all Ruby files in 'lib/', except this file
Dir[File.join(__dir__, '*.rb')].each do |file|
  require file unless file.end_with?('/stabilize_video.rb')
end

def main
  help 'Video file name must be provided.' if ARGV.empty?
  help 'Too many parameters specified.' if ARGV.length > 1
  options = parse_options
  video_in = ARGV[0]
  video_out = "#{File.dirname video_in}/stabilized_#{File.basename video_in}"
  StablizeVideo.new(video_in, video_out, options).stabilize
end

main
