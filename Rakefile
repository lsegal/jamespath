task :default => :test

desc 'Run all tests'
task :test do
  sh "ruby #{FileList['test/**_test.rb'].join(' ')}"
end
