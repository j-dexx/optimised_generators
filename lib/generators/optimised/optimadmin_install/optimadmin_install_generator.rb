module Optimised
  module Generators
    class OptimadminInstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Installs optimadmin engine"

      def mount_engine
        route 'mount Optimadmin::Engine => "/admin"'
      end

      def routes
        append_to_file 'config/routes.rb', default_routes
      end

      def sidebar
        copy_file 'sidebar/_module_links.html.erb', 'app/views/optimadmin/shared/sidebar/_module_links.html.erb'
      end

      def presenters
        directory 'presenters', 'app/presenters'
      end

      def menu_items
        copy_file 'menu_items/_menu_item.html.erb', 'app/views/menu_items/_menu_item.html.erb'
      end

      def navigation_contsants
        copy_file 'initializers/navigation_constants.rb', 'config/initializers/navigation_constants.rb'
      end

      def helpers
        copy_file 'helpers/presenter_helper.rb', 'app/helpers/presenter_helper.rb'
        copy_file 'helpers/application_helper.rb', 'app/helpers/application_helper.rb'
      end

      private

      def default_routes
        <<-ROUTES
Optimadmin::Engine.routes.draw do
  concern :imageable do
    member do
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end

  concern :orderable do
    collection do
      post 'order'
    end
  end

  concern :toggleable do
    member do
      get 'toggle'
    end
  end
end
        ROUTES
      end
    end
  end
end
