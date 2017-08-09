require 'net/http'
require 'json'
require 'yaml'

config = YAML.load_file(File.expand_path("../app.yml", __FILE__))
token = config["token"]
url = config["url"]
uri = URI("#{url}?auth_token=#{token}")

Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|

  # GET
  # request = Net::HTTP::Get.new uri
  # response = http.request request
  # puts response.code
  # puts response.body


  # POST
  # request = Net::HTTP::Post.new uri
  # request["Content-Type"] = "application/json"
  # request.body = {
  #   "color":"green",
  #   "message":"My first notification (yey)",
  #   "notify":false,
  #   "message_format":"text"
  # }.to_json
  #
  # response = http.request request
  # puts response.code
  # puts response.body


end
