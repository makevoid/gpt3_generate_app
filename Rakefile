desc "Run"
task :run do
  sh "bundle exec ruby gpt3_generate_app.rb"
end

desc "Spec - run tests"
task :spec do
  sh "bundle exec rspec"
end

desc "Run rack app"
task :app do
  sh "cd ./test_app && pkill -f puma; BUNDLE_GEMFILE=./Gemfile bundle exec rackup -p 3000"
end


task default: :run
