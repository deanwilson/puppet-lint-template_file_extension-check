require 'spec_helper'

describe 'template_file_extension' do
  ##########################
  # Valid examples
  ##########################
  context 'template function with one valid file name' do
    let(:code) do
      <<-TEST_CLASS
        class valid_template_filename {
          file { '/tmp/templated':
            content => template('mymodule/single_file.erb'),
          }
        }
      TEST_CLASS
    end

    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'epp function with one valid file name' do
    let(:code) do
      <<-TEST_CLASS
        class valid_epp_template_filename {
          file { '/tmp/templated':
            content => epp('mymodule/single_file.epp'),
          }
        }
      TEST_CLASS
    end

    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'epp function with one valid file name and parameters' do
    let(:code) do
      <<-TEST_CLASS
        class valid_epp_template_filename {
          file { '/tmp/templated':
            content => epp('mymodule/single_file.epp', {'key' => 'val'}),
          }
        }
      TEST_CLASS
    end

    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'space between template and opening paren' do
    let(:code) do
      <<-TEST_CLASS
        class space_between_template_and_opening_paren {
          file { '/tmp/templated':
            content => template ('mymodule/a_file.erb'),
          }
        }
      TEST_CLASS
    end

    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  ##########################
  # Invalid examples
  ##########################

  let(:template_msg) { 'all template file names should end with .erb' }

  context 'template function with single invalid file name' do
    let(:code) do
      <<-TEST_CLASS
        class multi_templated_file {
          file { '/tmp/templated':
            content => template('mymodule/first_file.erb', 'mymodule/second_file.conf'),
          }
        }
      TEST_CLASS
    end

    it 'should detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'should create a warning' do
      expect(problems).to contain_warning(template_msg).on_line(3).in_column(24)
    end
  end

  let(:epp_msg) { 'all epp file names should end with .epp' }

  context 'epp function with single invalid file name' do
    let(:code) do
      <<-TEST_CLASS
        class epp_multi_templated_file {
          file { '/tmp/templated':
            content => epp('mymodule/first_file', {'key' => 'val'}),
          }
        }
      TEST_CLASS
    end

    it 'should detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'should create a warning' do
      expect(problems).to contain_warning(epp_msg).on_line(3).in_column(24)
    end
  end

  context 'space between template and opening paren and no extension' do
    let(:code) do
      <<-TEST_CLASS
        class space_between_template_and_opening_paren {
          file { '/tmp/templated':
            content => template ('mymodule/a_file'),
          }
        }
      TEST_CLASS
    end

    it 'should detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'should create a warning' do
      expect(problems).to contain_warning(template_msg).on_line(3).in_column(24)
    end
  end
end
