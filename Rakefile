desc "Run"
task :run do
  # sh "bundle exec rackup -p 3000 -o 0.0.0.0"
  sh "bundle exec ruby gpt3_generate_app.rb"
end

desc "Spec - run tests"
task :spec do
  sh "bundle exec rspec"
end



task default: :run
