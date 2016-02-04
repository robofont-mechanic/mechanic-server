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

    def_delegator :remote, :username, :user
    def_delegator :remote, :name,     :repo
    def_delegator :remote, :source

    private

      def set_description
        self.description = remote.summary || remote.description
      end

      def set_author
        self.author = remote.developer
      end

      def repository_exists
        return if repository.blank?

        if !remote.file_exists?
          errors.add :filename, "doesn't exist in repository"
        end

      rescue GitHub::InvalidRepository
        errors.add :repository, "doesn't exist (#{remote})"
      end

      def remote
        @remote ||= GitHub::ExtensionRepository.new repository, filename
      end

  end
end
