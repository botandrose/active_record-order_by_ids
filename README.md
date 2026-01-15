# ActiveRecord::OrderByIds

[![CI](https://github.com/botandrose/active_record-order_by_ids/actions/workflows/ci.yml/badge.svg)](https://github.com/botandrose/active_record-order_by_ids/actions/workflows/ci.yml)

ActiveRecord scope methods for ordering by an explicit list of values.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record-order_by_ids'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_record-order_by_ids

## Usage

This gem adds two methods to active record scopes: `.order_by_ids`, and the more general `.order_by`.

Examples:

```ruby
user1 = User.create(id: 1)
user2 = User.create(id: 2)
user3 = User.create(id: 3)

User.order_by_ids([2,3,1]) #=> [user2, user3, user1]
```

```ruby
user3 = User.create(parent_id: 3)
user2 = User.create(parent_id: 2)
user1 = User.create(parent_id: 1)

User.order_by(parent_id: [2,3,1]) #=> [user2, user3, user1]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/botandrose/active_record-order_by_ids.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
