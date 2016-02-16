module GitHub

  class InvalidRepository < StandardError
  end

  autoload :ExtensionRepository, 'mechanic/server/github/extension_repository'
  autoload :FileTree,            'mechanic/server/github/file_tree'
  autoload :Plist,               'mechanic/server/github/plist'
  autoload :Repository,          'mechanic/server/github/repository'
  autoload :User,                'mechanic/server/github/user'

end
