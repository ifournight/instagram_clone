namespace :dev do
  desc "Rebuild dev system"
  task :build => ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:migrate']
  task :rebuild => [ 'dev:build', 'db:seed']
end