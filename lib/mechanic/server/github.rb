module GitHub

  class InvalidRepository < StandardError
  end

  autoload :FileTree,   'mechanic/server/github/file_tree'
  autoload :Repository, 'mechanic/server/github/repository'
  autoload :User,       'mechanic/server/github/user'

end
