require 'delegate'

class GitHub::ExtensionRepository < GitHub::Repository

  attr_reader :filename

  def initialize path, filename
    @filename = filename

    super path
  end

  def developer
    plist['developer']
  end

  def summary
    plist.dig 'com.robofontmechanic.Mechanic', 'summary'
  end

  def file_exists?
    files.file_exists? filename
  end

  def files
    GitHub::FileTree.new self
  end

  def plist
    GitHub::Plist.new self
  end

end
