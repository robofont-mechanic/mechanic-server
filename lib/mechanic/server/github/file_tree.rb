require 'octokit'

class GitHub::FileTree
  include Enumerable

  attr_reader :repository

  def initialize repository
    @repository = repository
  end

  def tree
    response = Octokit.tree repository, "HEAD", recursive: true
    response.tree
  rescue Octokit::NotFound, Octokit::InvalidRepository
    raise GitHub::InvalidRepository
  end

  def file_exists? filename
    any? {|file| File.fnmatch "*#{filename}", file.path}
  end

  def each *args, &block
    tree.each *args, &block
  end

end
