require_relative 'stabilize_video/version'

# Require all Ruby files in 'lib/', except this file
Dir[File.join(__dir__, '*.rb')].each do |file|
  require file unless file.end_with?('/stabilize_video.rb')
end

video_in = ARGV[0]
video_out = "stabilized_#{video_in}"
StablizeVideo.new(video_in, video_out).stabilize
