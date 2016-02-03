require 'spec_helper'

require 'mechanic/server/github'

module Mechanic
  class TestGitHubFileTree < Minitest::Test

    def test_finds_file_tree
      file_tree = GitHub::FileTree.new 'jackjennings/Dummy'
      assert file_tree.file_exists?('Dummy.roboFontExt')
    end

  end
end
