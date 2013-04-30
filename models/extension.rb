class Extension < ActiveRecord::Base
  
  validates :repository, :presence => true
  validates :filename, :presence => true
  validates :name, :presence => true, :uniqueness => true
  validate :repository_exists
  
  before_create :get_description
  before_create :get_author
  
  def repository_exists
    begin
      errors.add :filename, "doesn't exists in repository" unless files.tree.any? do |file|
        File.fnmatch "*#{filename}", file.path
      end
    rescue Github::Error::NotFound
      errors.add :repository, "doesn't exist"
    end
  end

  def github
    @github ||= Github.new do |config|
      config.user = user
      config.repo = repo
    end
  end
  
  def commits
    @commits ||= github.repos.commits.all(client_id: ENV['GITHUB_ID'], client_secret: ENV['GITHUB_SECRET'])
  end
  
  def files
    github.git_data.trees.get user, repo, commits.first.sha, recursive: true, client_id: ENV['GITHUB_ID'], client_secret: ENV['GITHUB_SECRET']
  end
  
  def get_description
    self.description = github.repos.get.description client_id: ENV['GITHUB_ID'], client_secret: ENV['GITHUB_SECRET']
  end
  
  def get_author
    u = github.users.get user: user, client_id: ENV['GITHUB_ID'], client_secret: ENV['GITHUB_SECRET']
    self.author = !u['name'].nil? ? u.name : u.login
  end
  
  def user
    self.repository.split('/', 2).first
  end
  
  def repo
    self.repository.split('/', 2).second
  end
  
end