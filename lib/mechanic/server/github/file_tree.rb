require 'octokit'
require 'base64'

class GitHub::FileTree
  include Enumerable

  attr_reader :repository

  def initialize repository
    @repository = repository
  end

  def tree
    response = Octokit.tree repository.to_s, "HEAD", recursive: true
    response.tree
  rescue Octokit::NotFound, Octokit::InvalidRepository
    raise GitHub::InvalidRepository
  end

  def file_exists? filename
    any? {|file| File.fnmatch "*#{filename}", file.path}
  end

  def read filename
    response = Octokit.contents repository.to_s, path: find_file(filename).path
    Base64.decode64 response.content
  end

  def find_file filename
    find {|file| File.fnmatch "*#{filename}", file.path}
  end

  def each *args, &block
    tree.each *args, &block
  end

end
