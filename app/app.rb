require 'sinatra'

class App < Sinatra::Base
  get "/" do
    "The App is working"
  end
end
