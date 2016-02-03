require 'octokit'

class GitHub::Repository

  attr_reader :path

  def initialize path
    @path = path
  end

  def description
    Octokit.repo(path).description
  end

  def username
    path.split('/', 2).first
  end

  def name
    path.split('/', 2).second
  end

  def source
    "https://github.com/#{path}"
  end

end
