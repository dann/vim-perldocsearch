desc "Copy the vim/doc files into ~/.vim"
task :deploy_local do
  run "cp plugin/perldocsearch.vim.vim ~/.vim/plugin"
  run "cp doc/perldocsearch.txt ~/.vim/doc"
end
 
desc "Create a zip archive for release to vim.org"
task :zip do
  abort "perldocsearch.zip already exists, aborting" if File.exist?("perldocsearch.zip")
  run "zip perldocsearch.zip plugin/perldocsearch.vim doc/perldocsearch.txt bin/podsearch"
end
 
def run(cmd)
  puts "Executing: #{cmd}"
  system cmd
end

