module Optimised
  module Generators
    class OptimadminViewsGenerator < Rails::Generators::NamedBase
      include Optimised::Generators::OptimadminViews::ImageHelpers
      include Optimised::Generators::OptimadminViews::DocumentHelpers

      source_root File.expand_path("../templates", __FILE__)
      argument :attributes, type: :array, default: [], banner: 'field:type'
      class_option :pagination, type: :boolean, default: true
      class_option :images, type: :array, default: [],
        desc: "List of images"
      class_option :documents, type: :array, default: [],
        desc: "List of documents"

      def add_index
        raise generator_string
        generate("optimised:optimadmin_views:index", generator_string)
      end

      def add_new
        generate("optimised:optimadmin_views:new", name)
      end

      def add_edit
        generate("optimised:optimadmin_views:edit", name)
      end

      def add_form
        generate("optimised:optimadmin_views:form", generator_string)
      end

      private

      def generator_string
        [ name, passed_attributes, generator_options ].join(" ")
      end

      def passed_attributes
        attributes.map{|x| "#{ x.name }:#{ x.type }" }.join(" ")
      end

      def generator_options
        options = []
        options << image_options
        options << document_options
        options << pagination_options
        options.compact.join(" ")
      end

      def pagination_options
        if options.pagination?
          "--pagination"
        else
          "--no-pagination"
        end
      end

      def document_options
        return unless has_document?
        "--documents #{ documents.join(" ") }"
      end

      def image_options
        return unless has_image?
        "--images #{ images.join(" ") }"
      end
    end
  end
end
