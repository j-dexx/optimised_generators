require 'test_helper'

class OptimadminRouteGeneratorTest < Rails::Generators::TestCase
  tests Optimised::Generators::OptimadminRouteGenerator
  destination File.expand_path("../../tmp", __FILE__)

  def setup
    prepare_destination
    copy_routes
  end

  def teardown
    tmp_dir = File.expand_path("../tmp", __FILE__)
    FileUtils.rm_rf(Dir.glob("#{ tmp_dir }/*"))
  end

  def test_route_insertion_without_additional_routes
    run_generator %w( Page --no-toggle --no-image --no-order )

    assert_file 'config/routes.rb' do |routes|
      assert_match("resources :pages", routes)
    end
  end

  def test_orderable_route
    run_generator %w( Page --order --no-toggle --no-image )

    assert_file 'config/routes.rb' do |routes|
      assert_match("resources :pages, concerns: [:orderable]", routes)
    end
  end

  def test_toggleable_route
    run_generator %w( Page --toggle --no-order --no-image )

    assert_file 'config/routes.rb' do |routes|
      assert_match("resources :pages, concerns: [:toggleable]", routes)
    end
  end

  def test_imageable_route
    run_generator %w( Page --image --no-toggle --no-order )

    assert_file 'config/routes.rb' do |routes|
      assert_match("resources :pages, concerns: [:imageable]", routes)
    end
  end

  def test_route_with_all_options
    run_generator %w( Page --image --toggle --order )

    assert_file 'config/routes.rb' do |routes|
      assert_match("resources :pages, concerns: [:imageable, :orderable, :toggleable]", routes)
    end
  end

  def copy_routes
    routes = File.expand_path("../../support/optimadmin_routes.rb", __FILE__)
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, "#{ destination }/routes.rb"
  end
end
