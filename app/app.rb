require 'sinatra'
require 'pry'
require 'json'

class App < Sinatra::Base
  get "/" do
    "The App is working"
  end

  post "/meme" do
    payload = Chappie::Parser.parse(request)
    Chappie::Actor.new(payload).act
    ""
  end
end
