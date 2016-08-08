require 'test_helper'

module OptimadminViews
  class PartialGeneratorTest < Rails::Generators::TestCase
    tests Optimised::Generators::OptimadminViews::PartialGenerator
    destination File.expand_path("../../../tmp", __FILE__)

    def setup
      prepare_destination
    end

    def teardown
      tmp_dir = File.expand_path("../../../tmp", __FILE__)
      FileUtils.rm_rf(Dir.glob("#{ tmp_dir }/*"))
    end

    def test_with_default_options
      run_generator %w( Page )
      
      assert_file 'app/views/optimadmin/pages/_page.html.erb' do |partial|
        assert_match 'large-8 small-8 columns', partial
        refute_match 'large-6 small-8 columns', partial
      end
    end
  end
end
