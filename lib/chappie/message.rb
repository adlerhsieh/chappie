require 'net/http'
require 'json'

module Chappie
  class Message
    include Config

    def initialize(room_id="", options={})
      @room_id = room_id
      @options = options
    end

    def uri
      URI("#{host}/v2/room/#{@room_id}/notification?auth_token=#{token}")
    end

    def send_message
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Post.new uri
        request["Content-Type"] = "application/json"
        # request.body = {
        #   "color":"green",
        #   "message":"My first notification (yey)",
        #   "notify":false,
        #   "message_format":"text"
        # }.to_json
        request.body = @options.to_json

        response = http.request request
        puts response.code
        puts response.body

      end
    end
  end
end

