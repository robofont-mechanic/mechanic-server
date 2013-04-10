class Extension < ActiveRecord::Base
  
  validates :repository, :presence => true
  validates :filename, :presence => true
  validates :name, :presence => true
  validate :repository_exists
  
  def repository_exists
    user, repo = self.repository.split '/', 2
    begin
      github = Github.new :user => user, :repo => repo
      sha = github.repos.commits.all.first.sha
      files = github.git_data.trees.get user, repo, sha, recursive: true
      errors.add :filename, "doesn't exists in repository" unless files.tree.any? do |file|
        File.fnmatch "*#{filename}", file.path
      end
    rescue Github::Error::NotFound
      errors.add :repository, "doesn't exist"
    end
  end
  
end