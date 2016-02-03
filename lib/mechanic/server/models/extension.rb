require 'forwardable'

require 'mechanic/server/github'

module Mechanic
  class Extension < ActiveRecord::Base
    extend Forwardable

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

    def_delegator :github_repository, :username, :user
    def_delegator :github_repository, :name,     :repo
    def_delegator :github_repository, :source

    private

      def set_description
        self.description = github_repository.description
      end

      def set_author
        self.author = github_user.name
      end

      def repository_exists
        return if repository.blank?
        begin
          if !github_tree.file_exists? filename
            errors.add :filename, "doesn't exists in repository"
          end
        rescue GitHub::InvalidRepository
          errors.add :repository, "doesn't exist"
        end
      end

      def github_tree
        GitHub::FileTree.new repository
      end

      def github_repository
        GitHub::Repository.new repository
      end

      def github_user
        GitHub::User.new user
      end

  end
end
