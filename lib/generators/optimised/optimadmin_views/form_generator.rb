module Optimised
  module Generators
    module OptimadminViews
      class FormGenerator < Rails::Generators::NamedBase
        include Optimised::Generators::OptimadminViews::ImageHelpers
        include Optimised::Generators::OptimadminViews::DocumentHelpers

        source_root File.expand_path("../templates", __FILE__)

        argument :attributes, type: :array, default: [], banner: 'field:type'
        class_option :images, type: :array, default: [],
          desc: "List of images"
        class_option :documents, type: :array, default: [],
          desc: "List of documents"

        def add_view
          template "_form.html.erb",
            "app/views/optimadmin/#{ plural_name }/_form.html.erb"
        end

        private

        def has_media?
          has_image? || has_document?
        end

        def media
          images + documents
        end

        def text_attributes
          attrs = attributes.select{|x| [:string, :text].include?(x.type) }
          attrs = attrs.reject{|x| media.include?(x.name) }
          attrs
        end

        def date_attributes
          attributes.select{|x| x.type == :date }
        end

        def non_settings_datetime_attributes
          datetime_attributes.reject{|x| datetime_setting_names.include?(x.name) }
        end

        def datetime_settings_attributes
          datetime_attributes.select{|x| datetime_setting_names.include?(x.name) }
        end

        def datetime_attributes
          attributes.select{|x| x.type == :datetime }
        end

        def datetime_setting_names
          %w( publish_at expire_at )
        end

        def numeric_attributes
          attrs = attributes.select{|x| [:decimal, :float, :integer].include?(x.type) }
          attrs = attrs.reject{|x| x.name == "position" }
          attrs
        end

        def boolean_attributes
          attributes.select{|x| x.type == :boolean }
        end
      end
    end
  end
end
