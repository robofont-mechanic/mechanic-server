require 'spec_helper'
require 'minitest/mock'

require 'mechanic/server/models/extension'

module Mechanic
  class TestExtension < Minitest::Test

    def test_has_user
      assert_equal 'jackjennings', build_extension.user
    end

    def test_has_repo
      assert_equal 'Dummy', build_extension.repo
    end

    def test_has_source
      assert_equal 'https://github.com/jackjennings/Dummy', build_extension.source
    end

    def test_invalid_repository_name_should_fail_validation
      extension = build_extension repository: 'jackjennings/Dummy/foobar'

      refute extension.valid?
      assert extension.errors.full_messages.length > 0
    end

    def test_valid_if_repository_exists
      extension = build_extension
      assert extension.valid?, extension.errors.full_messages
    end

    def test_invalid_if_repository_doesnt_exist
      extension = build_extension repository: 'jackjennings/Dummy2'

      assert extension.invalid?
    end

    def test_invalid_if_description_doesnt_exist
      extension = build_extension({
        description: nil
      })

      assert_attribute_invalid :description, extension
    end

    def test_gets_description
      extension = build_extension
      extension.send :fetch_description!
      assert !extension.description.blank?
    end

    def test_gets_author
      extension = build_extension
      extension.send :fetch_author!
      assert !extension.author.blank?
    end

    def test_has_valid_file_extension
      extension = build_extension filename: "Dummy.robofontExt"

      assert_attribute_invalid :filename, extension
    end

    def test_uses_repository_description_as_fallback
      extension = build_extension description: nil

      extension.send(:remote).stub :summary, nil do
        extension.send :fetch_description!
        assert_equal "Blank RoboFont extension", extension.description
      end
    end

    private

      def build_extension(attrs = {})
        Extension.new attrs.reverse_merge({
          repository: 'jackjennings/Dummy',
          name: 'Dummy',
          filename: 'Dummy.roboFontExt',
          description: 'Foo'
        })
      end

      def assert_attribute_valid attribute, object
        object.class.validators_on attribute do |validator|
          assert validator.validate_each object, attribute, object.send(attribute)
        end
      end

      def assert_attribute_invalid attribute, object
        object.class.validators_on attribute do |validator|
          refute validator.validate_each object, attribute, object.send(attribute)
        end
      end

  end
end
