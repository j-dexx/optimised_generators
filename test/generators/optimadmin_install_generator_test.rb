require "test_helper"

class OptimadminInstallGeneratorTest < Rails::Generators::TestCase
  tests Optimised::Generators::OptimadminInstallGenerator
  destination File.expand_path("../../tmp", __FILE__)

  def setup
    prepare_destination
    copy_routes
  end

  def teardown
    tmp_dir = File.expand_path("../tmp", __FILE__)
    FileUtils.rm_rf(Dir.glob("#{ tmp_dir }/*"))
  end

  def test_mounts_engine
    run_generator

    assert_file 'config/routes.rb' do |routes|
      assert_match(/mount Optimadmin::Engine => "\/admin"/, routes)
    end
  end

  def test_add_optimadmin_route_block
    run_generator

    assert_file 'config/routes.rb' do |routes|
      assert_match(/Optimadmin::Engine.routes.draw/, routes)
      assert_match(/concern :imageable/, routes)
      assert_match(/concern :orderable/, routes)
      assert_match(/concern :toggleable/, routes)
    end
  end

  def test_add_sidebar
    run_generator

    assert_file 'app/views/optimadmin/shared/sidebar/_module_links.html.erb'
  end

  def test_presenters_added
    run_generator

    assert_file 'app/presenters/optimadmin/base_presenter.rb'
    assert_file 'app/presenters/base_presenter.rb'
    assert_file 'app/presenters/menu_item_presenter.rb'
  end

  def test_menu_items
    run_generator

    assert_directory 'app/views/menu_items'
    assert_file 'app/views/menu_items/_menu_item.html.erb'
  end

  def test_navigation_constants
    run_generator

    assert_file 'config/initializers/navigation_constants.rb'
  end

  def test_helpers
    run_generator

    assert_file 'app/helpers/presenter_helper.rb'
    assert_file 'app/helpers/application_helper.rb'
  end

  def copy_routes
    routes = File.expand_path("../../support/blank_routes.rb", __FILE__)
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, "#{ destination }/routes.rb"
  end
end
