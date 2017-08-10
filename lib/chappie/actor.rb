require 'net/http'
require 'json'
require 'base64'
require 'open-uri'

module Chappie
  class Actor
    include Config

    def initialize(payload = {})
      @room    = payload["item"]["room"]
      @message = payload["item"]["message"]["message"] rescue nil
      @body    = @message.to_s.gsub("/meme ", "")
    end

    def room_id
      @room_id ||= @room["id"]
    end

    def act
      # Share.new("3704777", "false-alerm.png").send_file
      Share.new(room_id, "false-alerm.png").send_file

      # Message.new("3704777", {
      #   "color":"green",
      #   "message":"My first notification (yey)",
      #   "notify":false,
      #   "message_format":"text"
      # }).send_message

      # url = config["url"]
      # uri = URI("#{url}?auth_token=#{token}")

      # Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|

        # request = Net::HTTP::Get.new uri
        # response = http.request request
        # puts response.code
        # puts response.body


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

#         path = File.expand_path("../../../public/assets/images/false-alerm.png", __FILE__)
#         data64 = open(path).read
#         request = Net::HTTP::Post.new uri
#         request["Content-Type"] = "multipart/related; boundary=message_boundary"
#         request.body = "
# --message_boundary
# Content-Type: application/json; charset=UTF-8
# Content-Disposition: attachment; name=\"image_name\"
#
# {\"message\": \"This file is uploaded using API\"}
# --message_boundary
# Content-Type: image/png
# Content-Disposition: attachment; name=\"file\"; filename=\"image.png\"
#
# #{data64}
# --message_boundary
#         "
#         response = http.request request
#         puts response.code
#         puts response.body

      # end
    end
  end
end
