require 'yaml'

module Chappie
  Config = YAML.load_file(File.expand_path("../../../config/app.yml", __FILE__))
end
