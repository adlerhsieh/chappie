require 'net/http'

module Chappie
  class Share
    include Config

    def initialize(room_id="", filename="")
      @room_id = room_id
      @filename = filename
    end

    def uri
      URI("#{host}/v2/room/#{@room_id}/share/file?auth_token=#{token}")
    end

    def file
      @file ||= File.expand_path("../../../public/assets/images/#{@filename}", __FILE__)
    end

    def send_file
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        data64 = open(file).read
        request = Net::HTTP::Post.new uri
        request["Content-Type"] = "multipart/related; boundary=message_boundary"
        request.body = "
--message_boundary
Content-Type: application/json; charset=UTF-8
Content-Disposition: attachment; name=\"image_name\"

{\"message\": \"\"}
--message_boundary
Content-Type: image/png
Content-Disposition: attachment; name=\"file\"; filename=\"image.png\"

#{data64}
--message_boundary
        "
        response = http.request request
        puts response.code

      end
    end
  end
end
