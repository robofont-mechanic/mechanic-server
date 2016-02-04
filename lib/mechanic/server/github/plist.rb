require 'plist'
require 'forwardable'

class GitHub::Plist
  extend Forwardable

  attr_reader :repository

  def_delegator :remote, :dig
  def_delegator :remote, :[]

  def initialize repository
    @repository = repository
  end

  private

    def remote
      @remote ||= Plist::parse_xml read repository.filename
    rescue GitHub::InvalidRepository
      Hash.new
    end

    def read filename
      repository.files.read("#{filename}/info.plist")
    end

end
