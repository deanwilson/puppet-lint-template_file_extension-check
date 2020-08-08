require 'spec_helper'

describe 'template_file_extension' do
  ##########################
  # Valid examples
  ##########################
  context 'when the template function is called with one valid file name' do
    let(:code) do
      <<-TEST_CLASS
        class valid_template_filename {
          file { '/tmp/templated':
            content => template('mymodule/single_file.erb'),
          }
        }
      TEST_CLASS
    end

    it 'does not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'when the epp function is called with one valid file name' do
    let(:code) do
      <<-TEST_CLASS
        class valid_epp_template_filename {
          file { '/tmp/templated':
            content => epp('mymodule/single_file.epp'),
          }
        }
      TEST_CLASS
    end

    it 'does not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'when the epp function is called with one valid file name and parameters' do
    let(:code) do
      <<-TEST_CLASS
        class valid_epp_template_filename {
          file { '/tmp/templated':
            content => epp('mymodule/single_file.epp', {'key' => 'val'}),
          }
        }
      TEST_CLASS
    end

    it 'does not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'when a space it present between the template function and opening paren' do
    let(:code) do
      <<-TEST_CLASS
        class space_between_template_and_opening_paren {
          file { '/tmp/templated':
            content => template ('mymodule/a_file.erb'),
          }
        }
      TEST_CLASS
    end

    it 'does not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  ##########################
  # Invalid examples
  ##########################

  context 'when the template function is called with a single invalid file name' do
    let(:template_msg) { 'all template file names should end with .erb' }
    let(:code) do
      <<-TEST_CLASS
        class multi_templated_file {
          file { '/tmp/templated':
            content => template('mymodule/first_file.erb', 'mymodule/second_file.conf'),
          }
        }
      TEST_CLASS
    end

    it 'detects a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(template_msg).on_line(3).in_column(24)
    end
  end

  context 'when the epp function is called with a single invalid file name' do
    let(:epp_msg) { 'all epp file names should end with .epp' }

    let(:code) do
      <<-TEST_CLASS
        class epp_multi_templated_file {
          file { '/tmp/templated':
            content => epp('mymodule/first_file', {'key' => 'val'}),
          }
        }
      TEST_CLASS
    end

    it 'detects a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(epp_msg).on_line(3).in_column(24)
    end
  end

  context 'when there is a space between the template function and opening paren, and no extension is provided' do
    let(:template_msg) { 'all template file names should end with .erb' }

    let(:code) do
      <<-TEST_CLASS
        class space_between_template_and_opening_paren {
          file { '/tmp/templated':
            content => template ('mymodule/a_file'),
          }
        }
      TEST_CLASS
    end

    it 'detects a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(template_msg).on_line(3).in_column(24)
    end
  end
end
