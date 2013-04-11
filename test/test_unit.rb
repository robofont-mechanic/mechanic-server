require './mechanic-server'
require 'minitest/autorun'

class TestExtension < MiniTest::Unit::TestCase
  def setup
    @extension = Extension.new repository: 'jackjennings/Dummy'
  end
  
  def test_has_user
    assert_equal 'jackjennings', @extension.user
  end
  
  def test_has_repo
    assert_equal 'Dummy', @extension.repo
  end
  
  def test_has_github
    assert_instance_of Github::Client, @extension.github
    assert_equal 'jackjennings', @extension.github.user
    assert_equal 'Dummy', @extension.github.repo
  end
end