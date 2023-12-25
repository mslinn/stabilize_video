require 'colorator'
require 'optparse'

def help(msg = nil)
  printf "Error: #{msg}\n\n".yellow unless msg.nil?
  msg = <<~END_HELP
    stabilize: Stabilizes a video using FFmpeg's vidstabdetect and vidstabtransform filters.

    Syntax: stabilize PATH_TO_VIDEO

    stabilize: Stabilizes a video using FFmpeg's vidstabdetect and vidstabtransform filters.

    Syntax: stabilize [Options] PATH_TO_VIDEO

    Options:
      -f Overwrite output file if present
      -h Show this help message
      -s Shakiness compensation 1..10 (default 5)
      -z Zoom percentage (computed if not specified)

    See:
      https://www.ffmpeg.org/ffmpeg-filters.html#vidstabdetect-1
      https://www.ffmpeg.org/ffmpeg-filters.html#toc-vidstabtransform-1
  END_HELP
  printf msg.cyan
  exit 1
end

def parse_options
  options = { shake: 5 }
  OptionParser.new do |parser|
    parser.program_name = File.basename __FILE__
    @parser = parser

    parser.on('-f', '--overwrite', 'Overwrite output file if present')
    parser.on('-h', '--help', 'Display help') do
      help
    end
    parser.on('-s', '--shake SHAKE', Integer, 'Shakiness (1..10)')
    parser.on('-z', '--zoom ZOOM', Integer, 'Zoom percentage')

    parser.on_tail('-h', '--help', 'Show this message') do
      puts parser.to_s.cyan
      exit
    end
  end.parse!(into: options)
  help "Invalid shake value (#{options[:shake]})." if options[:shake].negative? || options[:shake] > 10
  options
end
