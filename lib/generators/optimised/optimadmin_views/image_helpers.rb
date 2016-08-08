module Optimised
  module Generators
    module OptimadminViews
      module ImageHelpers
        private

        def has_image?
          images.present?
        end

        def images
          Array(options.images)
        end
      end
    end
  end
end
