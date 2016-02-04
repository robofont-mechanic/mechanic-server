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

    def test_valid_repository_name
      extension = build_extension repository: 'jackjennings/Dummy/foobar'
      refute extension.valid?
      assert extension.errors.full_messages.length > 0
    end

    def test_valid_if_repository_exists
      extension = build_extension
      assert extension.valid?, extension.errors.full_messages
    end

    def test_invalid_if_repository_doesnt_exist
      assert !build_extension(repository: 'jackjennings/Dummy2').valid?
    end

    def test_invalid_if_description_doesnt_exist
      extension = build_extension
      extension.description = nil
      assert extension.invalid?
      assert extension.errors[:description].any?, extension.errors.inspect
    end

    def test_gets_description
      extension = build_extension
      extension.send :set_description
      assert !extension.description.blank?
    end

    def test_gets_author
      extension = build_extension
      extension.send :set_author
      assert !extension.author.blank?
    end

    def test_has_valid_file_extension
      extension = build_extension filename: "Dummy.robofontExt"

      refute extension.valid?
      assert extension.errors[:filename].any?, extension.errors.full_messages
    end

    def test_uses_repository_description_as_fallback
      extension = build_extension
      extension.description = nil
      extension.send(:remote).stub :summary, nil do
        extension.send :set_description
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

  end
end
