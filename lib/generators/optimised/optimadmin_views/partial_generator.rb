module Optimised
  module Generators
    module OptimadminViews
      class IndexGenerator < Rails::Generators::NamedBase
        include Optimised::Generators::OptimadminViews::ImageHelpers
        source_root File.expand_path("../templates", __FILE__)

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
      end
    end
  end
end
