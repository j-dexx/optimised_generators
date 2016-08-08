module Optimised
  module Generators
    module OptimadminViews
      class EditGenerator < Rails::Generators::NamedBase
        source_root File.expand_path("../templates", __FILE__)

        def add_view
          template "edit.html.erb",
            "app/views/optimadmin/#{ plural_name }/edit.html.erb"
        end
      end
    end
  end
end
