$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'

require 'optimised_generators'
require "rails/generators/test_case"

Minitest.after_run do
  tmp_dir = File.expand_path("../tmp", __FILE__)
  # FileUtils.remove_dir(tmp_dir)
end
