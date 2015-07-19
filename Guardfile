guard :minitest do
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^mechanic/(.*/)?([^/]+)\.rb$}) { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})       { 'test' }
end
