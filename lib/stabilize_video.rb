require_relative 'stabilize_video/version'

# Require all Ruby files in 'lib/', except this file
Dir[File.join(__dir__, '*.rb')].each do |file|
  require file unless file.end_with?('/stabilize_video.rb')
end

# Write the code for your gem here
