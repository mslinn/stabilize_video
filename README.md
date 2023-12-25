# `Stabilize_video` [![Gem Version](https://badge.fury.io/rb/stabilize_video.svg)](https://badge.fury.io/rb/stabilize_video)

`StabilizeVideo` provides the `stabilize` command, which uses `FFmpeg` to improve shakey videos.
Provided as a Ruby Gem, `StabilizeVideo` exposes an API which can be invoked from other programs.


## Installation

To use the `stabilize` command from a console, type:

```shell
$ gem install stabilize_video
```


### For a Ruby Program

If you would like to use the API from your Ruby program,
add the following line to your application&rsquo;s `Gemfile`:

```ruby
gem 'stabilize_video'
```

And then execute:

```shell
$ bundle
```


### For a Ruby Gem

If you would like to use the API from your Ruby gem,
 add the following to your gem&rsquo;s `.gemspec`:

```ruby
spec.add_dependency 'stabilize_video'
```

And then execute:

```shell
$ bundle
```


## Usage

This is the help message:

```shell
$ stabilize -h
stabilize: Stabilizes a video using FFmpeg's vidstabdetect and vidstabtransform filters.

Syntax: stabilize PATH_TO_VIDEO

stabilize: Stabilizes a video using FFmpeg's vidstabdetect and vidstabtransform filters.

Syntax: stabilize [Options] PATH_TO_VIDEO

Options:
  -f Overwrite output file if present
  -h Show this help message
  -s Shakiness compensation 1..10 (default 5)
  -v Verbosity; one of: trace, debug, verbose, info, warning, error, fatal, panic, quiet
  -z Zoom percentage (computed if not specified)

See:
  https://www.ffmpeg.org/ffmpeg-filters.html#vidstabdetect-1
  https://www.ffmpeg.org/ffmpeg-filters.html#toc-vidstabtransform-1
```


## Development

After checking out this git repository, install dependencies by typing:

```shell
$ bin/setup
```

You should do the above before running Visual Studio Code.


### Run the Tests

```shell
$ bundle exec rake test
```


### Interactive Session

The following will allow you to experiment:

```shell
$ bin/console
```


### Local Installation

To install this gem onto your local machine, type:

```shell
$ bundle exec rake install
```


### To Release A New Version

To create a git tag for the new version, push git commits and tags,
and push the new version of the gem to https://rubygems.org, type:

```shell
$ bundle exec rake release
```


## Contributing

Bug reports and pull requests are welcome at https://github.com/mslinn/stabilize_video.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
