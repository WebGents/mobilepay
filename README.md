# MobilePay

Actions with payments in MobilePay system.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mobilepay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mobilepay

## Usage

Create MobilePay object.

```ruby
  require 'mobilepay'
  translator = MobilePay::Client.new('merchant_id', 'subscription_key')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kortirso/mobilepay.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
