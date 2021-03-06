module Optimised
  module Generators
    module OptimadminViews
      class IndexGenerator < Rails::Generators::NamedBase
        include Optimised::Generators::OptimadminViews::ImageHelpers

        source_root File.expand_path("../templates", __FILE__)
        argument :attributes, type: :array, default: [], banner: 'field:type'
        class_option :pagination, type: :boolean, default: true
        class_option :images, type: :array, default: [],
          desc: "List of images"

        def add_view
          template "index.html.erb", "app/views/optimadmin/#{ plural_name }/index.html.erb"
        end

        private

        def paginated?
          options.pagination?
        end

        def orderable?
          attributes.detect{|x| x.name == "position" && x.type == :integer }.present?
        end

        def index_title_classes
          "large-#{ title_large_columns_number } small-8"
        end

        def title_large_columns_number
          number = 8
          number -= 2 if has_image?
          number -= 1 if orderable?
          number
        end
      end
    end
  end
end
