module Optimised
  module Generators
    class OptimadminRouteGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)
      class_option :image, type: :boolean, default: true,
        desc: "Include imageable concern"
      class_option :order, type: :boolean, default: false,
        desc: "Include orderable concern"
      class_option :toggle, type: :boolean, default: true,
        desc: "Include toggleable concern"

      desc "Inputs a route for optimadmin"

      def insert_route
        insert_into_file "config/routes.rb",
          route,
          after: "Optimadmin::Engine.routes.draw do\n"
      end

      private

      def route
        route_to_insert = "  resources :#{ plural_name }"
        route_to_insert << ", concerns: #{ concerns }" if has_concerns?
        route_to_insert << "\n"
        route_to_insert
      end

      def has_concerns?
        imageable? || orderable? || toggleable?
      end

      def concerns
        concerns_to_add = []
        concerns_to_add << :imageable if imageable?
        concerns_to_add << :orderable if orderable?
        concerns_to_add << :toggleable if toggleable?
        concerns_to_add
      end

      def imageable?
        options.image?
      end

      def orderable?
        options.order?
      end

      def toggleable?
        options.toggle?
      end
    end
  end
end
