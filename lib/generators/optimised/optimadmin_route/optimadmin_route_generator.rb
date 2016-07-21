module Optimised
  module Generators
    class OptimadminRouteGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      desc "Inputs a route for optimadmin"

      def insert_route
        insert_into_file "config/routes.rb",
          "  resources :#{ plural_name }\n",
          after: "Optimadmin::Engine.routes.draw do\n"
      end
    end
  end
end
