require 'net/http'
require 'json'
require 'yaml'
require 'base64'
require 'open-uri'

config = YAML.load_file(File.expand_path("../app.yml", __FILE__))
token = config["token"]
url = config["url"]
uri = URI("#{url}?auth_token=#{token}")

# data = File.read(File.expand_path("../assets/images/false-alerm.png", __FILE__))
# data64 = Base64.encode64(data)
data64 = open(File.expand_path("../assets/images/false-alerm.png", __FILE__)).read
# data64 = Base64.encode64(data)

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

  # POST IMAGE
  request = Net::HTTP::Post.new uri
  request["Content-Type"] = "multipart/related; boundary=message_boundary"
  # request["boundary"] = ""
  request.body = "
--message_boundary
Content-Type: application/json; charset=UTF-8
Content-Disposition: attachment; name=\"image_name\"

{\"message\": \"This file is uploaded using API\"}
--message_boundary
Content-Type: image/png
Content-Disposition: attachment; name=\"file\"; filename=\"image.png\"

#{data64}
--message_boundary
  "
  # request.body = {
  #   "color":"green",
  #   "message":"My first notification (yey)",
  #   "notify":false,
  #   "message_format":"text"
  # }.to_json

  response = http.request request
  puts response.code
  puts response.body
end
