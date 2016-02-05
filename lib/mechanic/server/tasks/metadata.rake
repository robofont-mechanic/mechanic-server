require './config/environment'
require 'mechanic/server/models/extension'

namespace :metadata do

  task :stats do
    extensions = Mechanic::Extension.all

    puts "Fetching summaries for:"

    summaries = extensions.map {|extension|
      print "- [ ] #{extension.filename} (#{extension.source})\r"

      extension.send(:remote).summary.tap do |s|
        puts (s ? "- [x] #{extension.filename} (#{extension.source})" : "- [ ] #{extension.filename} (#{extension.source})\r")
      end
    }.compact

    puts "#{summaries.count} of #{extensions.count} extensions have summaries"
  end

end
