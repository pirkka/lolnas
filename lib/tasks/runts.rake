desc "drop create migrate seed"
task :runts => [:"db:drop", :"db:create", :"db:migrate", :"db:seed"] do
  puts "RUNTS!"
end