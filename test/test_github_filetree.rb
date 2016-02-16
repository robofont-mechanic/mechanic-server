require 'spec_helper'

require 'mechanic/server/github'

module Mechanic
  class TestGitHubFileTree < Minitest::Test

    def test_finds_file_tree
      file_tree = GitHub::FileTree.new 'jackjennings/Dummy'
      assert file_tree.file_exists?('Dummy.roboFontExt')
    end

    def test_reads_a_file_from_tree
      file_tree = GitHub::FileTree.new 'jackjennings/Dummy'
      assert_equal %Q(<?xml version="1.0" encoding="UTF-8"?>\n),
                   file_tree.read('Dummy.roboFontExt/info.plist').lines.first
    end

  end
end
