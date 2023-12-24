require_relative 'lib/stabilize_video/version'

Gem::Specification.new do |spec|
  host = 'https://github.com/mslinn/stabilize_video'

  spec.authors               = ['Mike Slinn']
  spec.bindir                = 'exe'
  spec.executables           = ['stabilize']
  spec.description           = <<~END_DESC
    Stabilizes a video using FFmpeg's vidstabdetect and vidstabtransform filters.
  END_DESC
  spec.email                 = ['mslinn@mslinn.com']
  spec.files                 = Dir['.rubocop.yml', 'LICENSE.*', 'Rakefile', '{lib,spec}/**/*', '*.gemspec', '*.md']
  spec.homepage              = 'https://github.com/mslinn/stabilize_video'
  spec.license               = 'MIT'
  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'bug_tracker_uri'   => "#{host}/issues",
    'changelog_uri'     => "#{host}/CHANGELOG.md",
    'homepage_uri'      => spec.homepage,
    'source_code_uri'   => host,
  }
  spec.name                 = 'stabilize_video'
  spec.post_install_message = <<~END_MESSAGE

    Thanks for installing #{spec.name}!

  END_MESSAGE
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 3.1.0'
  spec.summary               = 'Stabilizes a video using FFmpeg\'s vidstabdetect and vidstabtransform filters.'
  spec.version               = StabilizeVideo::VERSION
  spec.add_dependency 'colorator', '~> 1.1'
  spec.add_dependency 'thor', '~> 1.2.2'
end
