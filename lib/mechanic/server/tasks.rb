current_directory = File.dirname __FILE__
tasks_glob = File.join current_directory, 'tasks', '*.rake'

Dir.glob(tasks_glob).each {|r| load r}
