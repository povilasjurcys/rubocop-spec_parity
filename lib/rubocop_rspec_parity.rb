# frozen_string_literal: true

require "rubocop"

require_relative "rubocop/rspec_parity"
require_relative "rubocop/rspec_parity/version"
require_relative "rubocop/rspec_parity/plugin"
require_relative "rubocop/cop/rspec_parity/no_let_bang"
require_relative "rubocop/cop/rspec_parity/public_method_has_spec"
require_relative "rubocop/cop/rspec_parity/sufficient_contexts"

# Inject default configuration (legacy support for RuboCop < 1.72)
# For RuboCop >= 1.72, use `plugins: rubocop-rspec_parity` in .rubocop.yml
default_config = File.expand_path("../config/default.yml", __dir__)
RuboCop::ConfigLoader.inject_defaults!(default_config) if File.exist?(default_config)
