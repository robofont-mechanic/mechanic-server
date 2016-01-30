require 'octokit'

module Mechanic
  class Extension < ActiveRecord::Base

    validates :repository,
              presence: true,
              format: {
                with: /\A[\w-]+\/[\w-]+\z/,
                message: "should be in the format username/repository name"
              }

    validates :filename,
              presence: true,
              uniqueness: {
                scope: :repository,
                message: "has already been added for this repository"
              },
              format: {
                with: /\A.*\.roboFontExt\z/,
                message: "should have the \"roboFontExt\" file extension"
              }

    validates :name,
              presence: true,
              uniqueness: true

    validate :repository_exists

    before_create :set_description
    before_create :set_author

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

    def user
      repository.split('/', 2).first
    end

    def repo
      repository.split('/', 2).second
    end

    def source
      "http://github.com/#{repository}"
    end

    private

    def file_exists? filename
      files.tree.any? do |file|
        File.fnmatch "*#{filename}", file.path
      end
    end

    def files
      Octokit.tree repository, "HEAD", recursive: true
    end

    def set_description
      self.description = Octokit.repo(repository).description
    end

    def set_author
      u = Octokit.user user
      self.author = !u['name'].nil? ? u.name : u.login
    end

  end
end
