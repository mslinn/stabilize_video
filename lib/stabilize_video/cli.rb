require 'thor'
require 'stabilize_video'

module StabilizeVideo
  class Cli < Thor
    include Thor::Actions

    desc 'do_something NAME', 'task description'
    def do_something(name)
      puts "do something with: #{name}"
    end
  end
end
