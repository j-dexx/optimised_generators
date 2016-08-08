require 'test_helper'

module OptimadminViews
  class IndexGeneratorTest < Rails::Generators::TestCase
    tests Optimised::Generators::OptimadminViews::IndexGenerator
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

      assert_file 'app/views/optimadmin/pages/index.html.erb' do |index_page|
        refute_match('<div class="module-sortable" data-module="Page">', index_page)
        refute_match('optimadmin/shared/module/index/order', index_page)
        refute_match('optimadmin/shared/module/index/pagination', index_page)
        refute_match('Image', index_page)
        assert_match('Manage Pages', index_page)
        assert_match("list_item 'large-8 small-8' do", index_page)
        assert_match("paginate @pages", index_page)
      end
    end

    def test_with_image
      run_generator %w( Page --images image )

      assert_file 'app/views/optimadmin/pages/index.html.erb' do |index_page|
        assert_match("list_item 'large-6 small-8' do", index_page)
        assert_match('Image', index_page)
      end
    end

    def test_with_multiword_name
      run_generator %w( WhateverName )

      assert_file 'app/views/optimadmin/whatever_names/index.html.erb' do |index_page|
        assert_match('Manage Whatever Names', index_page)
      end
    end

    def test_with_orderable
      run_generator %w( Page position:integer )

      assert_file 'app/views/optimadmin/pages/index.html.erb' do |index_page|
        assert_match('module-sortable', index_page)
      end
    end

    def test_without_pagination
      run_generator %w( Page --no-pagination )

      assert_file 'app/views/optimadmin/pages/index.html.erb' do |index_page|
        refute_match('paginate @pages', index_page)
      end
    end
  end
end
