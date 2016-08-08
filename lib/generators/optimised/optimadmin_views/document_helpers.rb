module Optimised
  module Generators
    module OptimadminViews
      module DocumentHelpers
        private

        def has_document?
          documents.present?
        end

        def documents
          Array(options.documents)
        end
      end
    end
  end
end
