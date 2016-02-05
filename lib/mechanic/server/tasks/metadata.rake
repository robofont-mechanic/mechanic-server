require './config/environment'
require 'mechanic/server/models/extension'

namespace :metadata do

  task :stats do
    extensions = Mechanic::Extension.all

    summaries = extensions.map {|extension|
      extension.send(:remote).summary
    }.compact

    puts "#{summaries.count} of #{extensions.count} extensions have summaries"
  end

end
