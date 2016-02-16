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

    validates :description,
              presence: {
                message: "must be set in the info.plist file or on your GitHub repository"
              }

    validate :repository_exists

    before_validation :fetch_description!, on: :create
    before_validation :fetch_author!,      on: :create

    def_delegator :remote, :username, :user
    def_delegator :remote, :name,     :repo
    def_delegator :remote, :source

    private

      def fetch_description!
        self.description = remote.summary || remote.description
      end

      def fetch_author!
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
