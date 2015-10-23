desc "update from github"

task :githubdate do
	p "Updating Engineering"
	system "cd ~/source/Engineering/; git pull"

end
