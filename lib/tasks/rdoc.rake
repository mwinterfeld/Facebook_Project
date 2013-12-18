require 'rdoc/task'

Rake::RDocTask.new do |rdoc|
	rdoc.rdoc_files.include('README.md')
	rdoc.rdoc_files.include('app/*/*.rb')
	rdoc.main = "README.md"
	rdoc.title = "Facebook Documentation"
	rdoc.rdoc_dir = 'rdoc'
end