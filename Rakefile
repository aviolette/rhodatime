require 'rake'
require 'rake/testtask'

task default: %w[test]

task :test do
  file_list = FileList.new
  file_list.include("test/**/*_test.rb")
  Rake::TestTask.new() do |t|
    t.name = "test:test"
    t.libs.concat(["test"])
    t.test_files = file_list
    t.verbose = false
  end
  Rake::Task["test:test"].invoke(file_list)
end