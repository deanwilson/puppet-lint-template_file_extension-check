require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end

require 'puppet-lint'

PuppetLint::Plugins.load_spec_helper
