require 'rubygems'
require 'bridge'

map "/api/1" do
  run Sinatra::Application
end

map "/" do
  run Rack::Directory.new("./graphene")
end
