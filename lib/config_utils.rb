module ConfigUtils
  def load_config
    conf = YAML.load_file "./config.yml"
    STATE[:config] = conf
  end
end
