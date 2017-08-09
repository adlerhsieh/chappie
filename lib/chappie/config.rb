require 'yaml'

module Chappie
  module Config
    def config
      YAML.load_file(File.expand_path("../../../config/app.yml", __FILE__))
    end

    def token
      @token ||= config["token"]
    end
  end
end
