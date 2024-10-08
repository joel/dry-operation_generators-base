# Operations::Base

Shared code of operation generators

See
 - [operation_generators](https://github.com/joel/dry-operation_generators)
 - [operation_generators-test_unit](https://github.com/joel/dry-operation_generators-test_unit)
 - [operation_generators-rspec](https://github.com/joel/dry-operation_generators-rspec)

## Installation

This gems is a dependency of [operation_generators](https://github.com/joel/dry-operation_generators), [operation_generators-test_unit](https://github.com/joel/dry-operation_generators-test_unit) and [operation_generators-rspec](https://github.com/joel/dry-operation_generators-rspec). It is not meant to be install in standalone.

NOTE: The gem needs to be required as `operations/base`

    $ gem "dry-operation_generators-base", require: "operations/base"

Otherwise, you can require "operations/base" on your code.

## Usage

require "operations/base"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joel/dry-operation_generators-base. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/joel/dry-operation_generators-base/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Operations::Base project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/joel/dry-operation_generators-base/blob/main/CODE_OF_CONDUCT.md).
