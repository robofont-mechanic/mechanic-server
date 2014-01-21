class Extension < ActiveRecord::Base
  
  validates :repository, presence: true
  validates :filename, presence: true, uniqueness: { scope: :repository, message: "has already been added for this repository." }
  validates :name, presence: true, uniqueness: true
  validate :repository_exists
  
  before_create :get_description
  before_create :get_author
  
  def repository_exists
    return if repository.blank?
    begin
      if !file_exists?(filename)
        errors.add :filename, "doesn't exists in repository"
      end
    rescue Octokit::NotFound
      errors.add :repository, "doesn't exist"
    end
  end
  
  def commits
    @commits ||= Octokit.commits(repository)
  end
  
  def files
    Octokit.tree repository, commits.first.sha, recursive: true
  end
  
  def get_description
    self.description = Octokit.repo(repository).description
  end
  
  def get_author
    u = Octokit.user user
    self.author = !u['name'].nil? ? u.name : u.login
  end
  
  def user
    self.repository.split('/', 2).first
  end
  
  def repo
    self.repository.split('/', 2).second
  end
  
  def file_exists? filename
    files.tree.any? do |file|
      File.fnmatch "*#{filename}", file.path
    end
  end
  
end