require 'net/http'
require 'json'
require 'base64'
require 'open-uri'

module Chappie
  class Actor
    def initialize(payload = {})
      @message = payload["item"]["message"]["message"] rescue nil
      @body = @message.to_s.gsub("/meme ", "")
    end

    def token
      @token ||= Config["token"]
    end

    def act
      url = Config["url"]
      uri = URI("#{url}?auth_token=#{token}")

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|

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

        path = File.expand_path("../../../public/assets/images/false-alerm.png", __FILE__)
        puts path
        data64 = open(path).read
        puts data64
        request = Net::HTTP::Post.new uri
        request["Content-Type"] = "multipart/related; boundary=message_boundary"
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
        response = http.request request
        puts response.code
        puts response.body

      end
    end
  end
end