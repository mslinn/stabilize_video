require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'stabilize_video'

require 'minitest/autorun'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Filter out Minitest backtrace while allowing backtrace from other libraries to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

