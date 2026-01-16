# RuboCop SpecParity

A RuboCop plugin that enforces spec parity and best practices in RSpec test suites. This gem helps ensure your Ruby code has proper test coverage and follows RSpec conventions.

## Features

This plugin provides three custom cops:

- **SpecParity/FileHasSpec**: Ensures every Ruby file in your app directory has a corresponding spec file
- **SpecParity/PublicMethodHasSpec**: Ensures every public method has spec test coverage
- **SpecParity/NoLetBang**: Disallows the use of `let!` in specs, encouraging explicit setup

## Assumptions

These cops work based on the following conventions:

- **File organization**: Each Ruby file has a corresponding spec file stored in the `spec/` directory, mirroring the same directory structure. For example, `app/models/user.rb` should have a spec at `spec/models/user_spec.rb`.
- **Spec file naming**: Spec files use the `_spec.rb` suffix.
- **Instance method specs**: Instance methods are tested using the convention `describe '#method_name' do`.
- **Class method specs**: Class methods are tested using the convention `describe '.class_method' do`.

If your project uses different conventions, these cops may not work as expected.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-spec_parity', require: false
```

And then execute:

```bash
bundle install
```

Or install it directly:

```bash
gem install rubocop-spec_parity
```

## Usage

Add `rubocop-spec_parity` to your `.rubocop.yml`:

```yaml
require:
  - rubocop-spec_parity

# For RuboCop >= 1.72
plugins:
  - rubocop-spec_parity
```

The default configuration enables all cops. You can customize them in your `.rubocop.yml`:

```yaml
SpecParity/FileHasSpec:
  Enabled: true
  Include:
    - 'app/**/*.rb'
  Exclude:
    - 'app/assets/**/*'
    - 'app/views/**/*'

SpecParity/PublicMethodHasSpec:
  Enabled: true
  Include:
    - 'app/**/*.rb'

SpecParity/NoLetBang:
  Enabled: true
  Include:
    - 'spec/**/*_spec.rb'
```

Run RuboCop as usual:

```bash
bundle exec rubocop
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/povilasjurcys/rubocop-spec_parity. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/povilasjurcys/rubocop-spec_parity/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RuboCop SpecParity project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/povilasjurcys/rubocop-spec_parity/blob/main/CODE_OF_CONDUCT.md).
