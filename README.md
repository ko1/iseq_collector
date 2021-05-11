# IseqCollector

This gem introduce several methods to `ObjectSpace` to operate all of iseq objects in a process.

## Background

Ruby (MRI) 2.2 and erlier, all of bytecode (iseq: instruction sequence) are `RubyVM::InstructionSequence` objects and we can touch them with `ObjectSpace.each_object` method.
However Ruby 2.3 and later does not expose iseqs by `RubyVM::InstructionSequence`. You need to use `RubyVM::InstructionSequence.of(proc or method object)` to get `RubyVM::InstructionSequence` and it is impossible to get all of iseqs in a process.

This gem provides `ObjectSpace.each_iseq`, `ObjectSpace.count_iseq` and `ObjectSpace.memsize_of_all_iseq` to get all of iseqs in a process for Ruby 2.3 and later. Future Ruby version can provide same purpose API, but not sure.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iseq_collector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iseq_collector

## Usage

`require 'iseq_collector'` adds the following singleton methods to `ObjectSpace` module.

* `ObjectSpace.each_iseq{|iseq| ...}`
* `ObjectSpace.count_iseq #=> Integer`
* `ObjectSpace.memsize_of_all_iseq #=> Integer` (this feature can be implemented by `ObjectSpace.each_iseq`)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/iseq_collector.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

