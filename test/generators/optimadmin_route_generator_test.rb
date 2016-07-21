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

  def test_route_insertion
    run_generator %w( Page )

    assert_file 'config/routes.rb' do |routes|
      assert_match(/resources :pages/, routes)
    end
  end

  def copy_routes
    routes = File.expand_path("../../support/optimadmin_routes.rb", __FILE__)
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, "#{ destination }/routes.rb"
  end
end
