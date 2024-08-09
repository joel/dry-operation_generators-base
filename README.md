# Operation Generators

Operation Generators is a utility library designed to create all the needed file for handling an operation with Dry RB ecosystem by automating the creation of a comprehensive set of files required for new Business Logic actions.

Reducing manual boilerplate code and enforcing a unified code structure enhances productivity and consistency while minimizing the potential for errors.

The following files are generated for the action `Create` of the resource `User`:

```shell
app/operations/users/create/
├── action.rb
├── contract.rb
├── operation.rb
├── register.rb
├── repository.rb
├── schema.rb
└── validation.rb
```

For those files, we need their test counterpart.

```shell
test/operations/users/create/
├── acction_test.rb
├── contract_test.rb
├── operation_test.rb
├── register_test.rb
├── repository_test.rb
├── schema_test.rb
└── validation_test.rb
```

Please check out [TestUnit Generators](https://github.com/orgs/joel/dry-operation_generators-test_unit)

The generator helps to reduce the burden and lower the boilerplate of adding a new action. On top of that, it helps reduce typos and make code more unified.

It aims to speed up the development.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add operation_generators

If Bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install operation_generators

NOTE: The gem needs to be required as `operations`

    $ gem "operation_generators", require: "operations"

Otherwise, you can require "operations" on your code.

## Usage

Once installed, you can print out the Rails Generators Help:

```shell
rails generate --help
```

The following Generators should appear:

```shell
Operations:
  operations:action
  operations:contract
  operations:operation
  operations:register
  operations:repository
  operations:schema
  operations:validation
```

You can print the help for any generator:

```shell
rails generate operations:<generator name> --help
```

To generate all at once use scaffold:

```shell
Operations:
  operations:scaffold
```

### Install Generator

The `install` generator needs to be run to install the shared files, such as `app/operations/application_contract.rb` of `app/operations/application_schema.rb`.

### Scaffold Generator

The `scaffold` generator calls all the generators at once.

```shell
rails generate operations:scaffold user create firstname:string{optional}
      create  app/operations/users/create/action.rb
      invoke  test_unit
      create    test/app/operations/users/create/contract_test.rb
      create  app/operations/users/base/contract.rb
      create  app/operations/users/create/contract.rb
      invoke  test_unit
      create    test/app/operations/users/create/schema_test.rb
      create  app/operations/users/base/schema.rb
      create  app/operations/users/create/schema.rb
      create  app/operations/users/create/validation.rb
      create  app/operations/users/create/repository.rb
      create  app/operations/users/create/register.rb
      invoke  test_unit
      create    test/app/operations/users/create/operation_test.rb
      create  app/operations/users/create/operation.rb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

There is a generator of generators you can use to quickly add a new generator:

```shell
./bin/generator <generator name> --no-dry_run
```

That provides the skeleton for the new generator. Note that the test suite should still run after the generated files.

Bug reports and pull requests are welcome on GitHub at https://github.com/orgs/joel/dry-operation_generators. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/joel/dry-operation_generators/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Isms project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/joel/dry-operation_generators/blob/main/CODE_OF_CONDUCT.md).
