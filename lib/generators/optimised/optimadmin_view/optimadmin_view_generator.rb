module Optimised
  module Generators
    class OptimadminViewGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)
      class_option :image, type: :boolean, default: true,
        desc: "Include imageable concern"

      def add_index
        template "index.html.erb", "app/views/optimadmin/#{ plural_name }/index.html.erb"
      end

      private

      def index_title_classes
        if image?
          'large-6 small-8'
        else
          'large-8 small-8'
        end
      end

      def image?
        options.image?
      end
    end
  end
end
