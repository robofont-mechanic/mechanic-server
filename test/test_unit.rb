require 'spec_helper'

class TestExtension < MiniTest::Unit::TestCase
  def setup
    @extension = Extension.new repository: 'jackjennings/Dummy', name: 'Dummy', filename: 'Dummy.roboFontExt'
    @badExtension = Extension.new repository: 'jackjennings/Dummy2', name: 'Dummy', filename: 'Dummy.roboFontExt'
  end

  def test_has_user
    assert_equal 'jackjennings', @extension.user
  end

  def test_has_repo
    assert_equal 'Dummy', @extension.repo
  end

  def test_valid_if_repository_exists
    assert @extension.valid?, @extension.errors.full_messages
  end

  def test_invalid_if_repository_doesnt_exist
    assert !@badExtension.valid?
  end

  def test_gets_description
    @extension.send :get_description
    assert !@extension.description.blank?
  end

  def test_gets_author
    @extension.send :get_author
    assert !@extension.author.blank?
  end
end
