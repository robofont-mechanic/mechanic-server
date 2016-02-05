require './config/environment'
require 'mechanic/server/models/extension'

namespace :metadata do

  task :stats do
    extensions = Mechanic::Extension.all

    summaries = extensions.map {|extension|
      print "Fetching summary for #{extension.filename} (#{extension.source})"

      extension.send(:remote).summary.tap do |s|
        puts (s ? " (found)" : "")
      end
    }.compact

    puts "#{summaries.count} of #{extensions.count} extensions have summaries"
  end

end
