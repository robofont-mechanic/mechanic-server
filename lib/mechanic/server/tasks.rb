dir = File.dirname __FILE__
Dir.glob(File.join(dir, 'tasks', '*.rake')).each {|r| load r}
