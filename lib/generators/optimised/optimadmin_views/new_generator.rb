module Optimised
  module Generators
    module OptimadminViews
      class NewGenerator < Rails::Generators::NamedBase
        source_root File.expand_path("../templates", __FILE__)

        def add_view
          template "new.html.erb",
            "app/views/optimadmin/#{ plural_name }/new.html.erb"
        end
      end
    end
  end
end
 
