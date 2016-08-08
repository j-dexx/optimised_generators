module Optimised
  module Generators
    module OptimadminViews
      class PartialGenerator < Rails::Generators::NamedBase
        include Optimised::Generators::OptimadminViews::ImageHelpers

        source_root File.expand_path("../templates", __FILE__)
        argument :attributes, type: :array, default: [], banner: 'field:type'
        class_option :images, type: :array, default: [],
          desc: "List of images"

        def add_view
          template "_partial.html.erb",
            "app/views/optimadmin/#{ plural_name }/_#{ singular_name }.html.erb"
        end

        private

        def orderable?
          attributes.detect{|x| x.name == "position" && x.type == :integer }.present?
        end

        def title_large_columns_number
          number = 8
          number -= 2 if has_image?
          number -= 1 if orderable?
          number
        end

        def image_name
          images.first
        end
      end
    end
  end
end
