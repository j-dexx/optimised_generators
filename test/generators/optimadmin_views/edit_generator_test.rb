require 'test_helper'

module OptimadminViews
  class EditGeneratorTest < Rails::Generators::TestCase
    tests Optimised::Generators::OptimadminViews::EditGenerator
    destination File.expand_path("../../../tmp", __FILE__)

    def setup
      prepare_destination
    end

    def teardown
      tmp_dir = File.expand_path("../../../tmp", __FILE__)
      FileUtils.rm_rf(Dir.glob("#{ tmp_dir }/*"))
    end

    def test_view
      run_generator %w( Page )

      assert_file 'app/views/optimadmin/pages/edit.html.erb' do |edit_page|
        assert_match('Edit Page', edit_page)
      end
    end
  end
end
