module AppTesting
  def test_app_run_app
    test_app_run_app_run_thread
    test_app_run_app_test
  end

  def test_app_run_app_test
    # url = "/weather"
    url = "/"
    out = run_cmd "curl http://localhost:3000#{url}"
    puts "OUTPUT: '#{out}' == OK"
    raise "AppTestFailedError - output doesn't match, app is probably not running" unless out == '{"status":"ok"}'
  end

  def test_app_run_app_run_thread
    Thread.new do
      run_cmd "cd ./test_app && pkill -f puma; BUNDLE_GEMFILE=./Gemfile bundle exec rackup -p 3000"
    end
    sleep 1
  end

  private

  def run_cmd(cmd)
    out = `#{cmd}`
    puts out
    out
  end
end
