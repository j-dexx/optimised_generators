require 'test_helper'

module OptimadminViews
  class NewGeneratorTest < Rails::Generators::TestCase
    tests Optimised::Generators::OptimadminViews::NewGenerator
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

      assert_file 'app/views/optimadmin/pages/new.html.erb' do |new_page|
        assert_match('New Page', new_page)
      end
    end
  end
end
