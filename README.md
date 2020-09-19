# puppet-lint template file extension check

Extends puppet-lint to ensure all file names used in template and epp
functions end with the string '.erb' or '.epp' respectively

[![Build Status](https://travis-ci.org/deanwilson/puppet-lint-template_file_extension-check.svg?branch=master)](https://travis-ci.org/deanwilson/puppet-lint-template_file_extension-check)

[![Actions Status](https://github.com/deanwilson/puppet-lint-template_file_extension-check/workflows/Ruby/badge.svg)](https://github.com/deanwilson/puppet-lint-template_file_extension-check/actions)
[![Actions Status](https://github.com/deanwilson/puppet-lint-template_file_extension-check/workflows/Rubocop%20linter/badge.svg)](https://github.com/deanwilson/puppet-lint-template_file_extension-check/actions)

This plugin is an extension of our local style guide and may not suit
your own code base. This sample would trigger the `puppet-lint` warning:

    class valid_template_filename {
      file { '/tmp/templated':
        content => template('mymodule/single_file.config'),
      }
    }

    # all template file names should end with .erb

And this would trigger an EPP (Embedded Puppet) specific warning:

    class epp_multi_templated_file {
      file { '/tmp/templated':
        content => epp('mymodule/first_file.epp', 'mymodule/second_file.conf'),
      }
    }

    # all epp file names should end with .epp

## Installation

To use this plugin add the following line to your Gemfile

    gem 'puppet-lint-template_file_extension-check'

and then run `bundle install`.

## Usage

This plugin provides a new check to `puppet-lint`.

    all template file names should end with .erb

    all epp file names should end with .epp

## Other puppet-lint plugins

You can find a list of my `puppet-lint` plugins in the
[unixdaemon puppet-lint-plugins](https://github.com/deanwilson/unixdaemon-puppet-lint-plugins) repo.

### Author

[Dean Wilson](https://www.unixdaemon.net)

### License

 * MIT
