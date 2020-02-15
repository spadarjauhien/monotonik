# Monotonik

![Monotonik](https://raw.githubusercontent.com/evgenygarl/monotonik/master/logo.PNG)

[![Gem Version](http://img.shields.io/gem/v/monotonik.svg)](https://rubygems.org/gems/monotonik) [![Gem Downloads](http://ruby-gem-downloads-badge.herokuapp.com/monotonik)](https://rubygems.org/gems/monotonik) [![Gem Total Downloads](http://ruby-gem-downloads-badge.herokuapp.com/monotonik?type=total)](https://rubygems.org/gems/monotonik)

[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT) [![Build Status](https://travis-ci.org/evgenygarl/monotonik.svg?branch=master)](https://travis-ci.org/evgenygarl/monotonik)

[Usually](https://github.com/search?utf8=%E2%9C%93&q=elapsed+time.now+language%3ARuby&type=Code), Ruby-developers measure elapsed time this way:

```ruby
t1 = Time.now
# time consuming operation
t2 = Time.now

time_elapsed = t2 - t1
```

But this way of measuring has an important issue: `Time.now` doesn't move only forwards 🤷‍♂️ It can be changed manually by the system administrator. Or system time on your machine may be changed during syncing with [NTP](http://www.ntp.org/) server. You can read more about this issue [here](https://blog.dnsimple.com/2018/03/elapsed-time-with-ruby-the-right-way/).
So, there is no guarantee that the new value returned by `Time.now` will be in the future, and the elapsed time calculated this way may be even a negative value 🤷‍♂️

If you want to measure elapsed time the right way, you should use the *monotonic clock*. Each time you request the time of the monotonic clock, time since a specific event is returned: for example, on macOS, this event is the system boot. Ruby provides a method to receive the current value of system monotonic clocks:

```ruby
t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# time consuming operation
t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

time_elapsed = t2 - t1
```

In its turn, `monotonik` gem provides tiny wrappers over this functionality to avoid writing a lot of boilerplate code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'monotonik'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install monotonik

## Usage

How to measure elapsed time using `monotonik`? Here is an example:

```ruby
start = Monotonik.clock_time
# time consuming operation
finish = Monotonik.clock_time

elapsed = finish - start #=> 14.73181
```

In order to avoid writing such boilerplate code, you can use `Monotonik.measure` method:

```ruby
result = Monotonik.measure { factorial(100_000) } # time consuming operation

result.value #=> very long number...
result.time #=> => 6.43604
```

Both `Monotonik.clock_time` and `Monotonik.measure` methods receive type of the return clock time value as the only argument. It can be set to one of the following values:
* `:float_second` - number of seconds as a float (by default)
* `:float_millisecond` - number of milliseconds as a float
* `:float_microsecond` - number of microseconds as a float
* `:second` - number of seconds as an integer
* `:millisecond` - number of milliseconds as an integer
* `:microsecond` - number of microseconds as an integer
* `:nanosecond` - number of nanoseconds as an integer

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`. To release a new version, update the version number in `version.rb`, and then run `bin/rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/evgenygarl/monotonik.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
