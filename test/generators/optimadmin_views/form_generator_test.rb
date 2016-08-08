require 'test_helper'

module OptimadminViews
  class FormGeneratorTest < Rails::Generators::TestCase
    tests Optimised::Generators::OptimadminViews::FormGenerator
    destination File.expand_path("../../../tmp", __FILE__)

    def setup
      prepare_destination
    end

    def teardown
      tmp_dir = File.expand_path("../../../tmp", __FILE__)
      FileUtils.rm_rf(Dir.glob("#{ tmp_dir }/*"))
    end

    def test_without_media
      run_generator %w( Page )

      assert_file 'app/views/optimadmin/pages/_form.html.erb' do |form|
        assert_match('optimadmin/shared/form_errors', form)
        assert_match('model: @page', form)
        assert_match('if @page.errors.any?', form)
        refute_match('Media', form)
        refute_match('tabs-3', form)
      end
    end

    def test_text_attrs
      run_generator %w( Page blah:string image:string document:string --images image --documents document )

      assert_file 'app/views/optimadmin/pages/_form.html.erb' do |form|
        assert_match('f.text_field :blah', form)
        refute_match('f.text_field :image', form)
        refute_match('f.text_field :document', form)
      end
    end

    def test_numeric_attributes
      run_generator %w( Page integer:integer float:float decimal:decimal position:integer )

      assert_file 'app/views/optimadmin/pages/_form.html.erb' do |form|
        refute_match('f.number_field :position', form)
        assert_match('f.number_field :integer', form)
        assert_match('f.number_field :float', form)
        assert_match('f.number_field :decimal', form)
      end
    end

    def test_date_attrs
      run_generator %w( Page date:date )

      assert_file 'app/views/optimadmin/pages/_form.html.erb' do |form|
        assert_match('f.datepicker_field :date', form)
      end
    end

    def test_datetime_attrs
      run_generator %w( Page date:datetime )

      assert_file 'app/views/optimadmin/pages/_form.html.erb' do |form|
        assert_match('f.datetimepicker_field :date', form)
      end
    end

    def test_datetime_settings_attrs
      run_generator %w( Page publish_at:datetime expire_at:datetime )

      assert_file 'app/views/optimadmin/pages/_form.html.erb' do |form|
        assert_match 'f.datetimepicker_field :publish_at', form
        assert_match 'f.datetimepicker_field :expire_at', form
      end
    end

    def test_with_images
      run_generator %w( Page image:string --images image )

      assert_file 'app/views/optimadmin/pages/_form.html.erb' do |form|
        assert_match('Media', form)
        assert_match('f.image_field :image', form)
      end
    end

    def test_with_documents
      run_generator %w( Page document:string --documents document )

      assert_file 'app/views/optimadmin/pages/_form.html.erb' do |form|
        assert_match('Media', form)
        assert_match('f.document_field :document', form)
      end
    end

    def test_booleans
      run_generator %w( Page display:boolean )

      assert_file 'app/views/optimadmin/pages/_form.html.erb' do |form|
        assert_match 'f.check_box :display', form
      end
    end
  end
end
