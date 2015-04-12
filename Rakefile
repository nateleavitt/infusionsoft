begin
  require 'rake/testtask'

  Rake::TestTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/*_test.rb', 'test/**/*_test.rb']
    t.verbose = true
  end
rescue LoadError
  #no test-unit available
end

task default: [:test]
