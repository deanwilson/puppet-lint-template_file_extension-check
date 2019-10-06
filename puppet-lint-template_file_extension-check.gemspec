Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-template_file_extension-check'
  spec.version     = '0.1.2'
  spec.homepage    = 'https://github.com/deanwilson/puppet-lint-template_file_extension-check'
  spec.license     = 'MIT'
  spec.author      = 'Dean Wilson'
  spec.email       = 'dean.wilson@gmail.com'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'puppet-lint template_file_extension check'
  spec.description = <<-EOF
    Extends puppet-lint to ensure all filenames used in template and epp functions
    end with the string '.erb' or '.epp' respectively
  EOF

  spec.add_dependency             'puppet-lint', '>= 1.1', '< 3.0'
  spec.add_development_dependency 'rspec', '~> 3.8.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rubocop', '~> 0.47.1'
  spec.add_development_dependency 'rake', '~> 13.0.0'
  spec.add_development_dependency 'rspec-json_expectations', '~> 1.4'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
end
