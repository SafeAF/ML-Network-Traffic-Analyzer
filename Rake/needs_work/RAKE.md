= Rake Tasks Overview

Contained are attempst at creating a fairly comprehensive automation suite



task :confirm do
  confirm_token = rand(36**6).to_s(36)
  STDOUT.puts "Confirm [ACTION]? Enter '#{confirm_token}' to confirm:"
  input = STDIN.gets.chomp
  raise "Aborting [ACTION]. You entered #{input}" unless input == confirm_token
end

Of course replace [ACTION] by something relevant (or something generic). This implementation generates a random 6-character string that you will need to enter before continuing.

You can then use it by calling it before your own tasks:

task :deploy_to_production => :confirm do
  ...
end
