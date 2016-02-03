require 'octokit'

class GitHub::Repository

  attr_reader :path

  def initialize path
    @path = path
  end

  def description
    Octokit.repo(path).description
  end

end
