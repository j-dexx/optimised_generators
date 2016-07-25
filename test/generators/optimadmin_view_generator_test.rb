require 'test_helper'

class OptimadminViewGeneratorTest < Rails::Generators::TestCase
  tests Optimided::Generators::OptimadminViewGenerator
  destination File.expand_path("../../tmp", __FILE__)
  
  def setup
    prepare_destination
  end

  def teardown
    tmp_dir = File.expand_path("../tmp", __FILE__)
    FileUtils.rm_rf(Dir.glob("#{ tmp_dir }/*"))
  end
  
  def test_with_no_options
  end
end
