require 'rubygems'
require 'redis'
require 'sinatra'
require 'sinatra/jsonp'
require 'json'
require 'pp'



set :logging, :true

@@db = Redis.new

# Data format:
# timestamp => [ name, value ]

def generate_output(data)
  # [{
  #   :target => "name",
  #   :datapoints => [
  #     [33,9304959348],
  #     [value,timestamp]]
  # }]
  # data.pretty_inspect
  o = {}
  data.each do |d|
    blob = JSON.parse(d[0])
    o[blob[0]] ||= []
    o[blob[0]].push([blob[1],d[1]])
  end
  
  output = []
  o.each do |series|
    blob = {
      :target => series[0],
      :datapoints => series[1]
    }
    output.push(blob)
  end
  output
end
  
get "/db/:key" do |key|
  JSONP generate_output(@@db.zrangebyscore(key,1000,Time.now.to_i,:with_scores => true))
end

post "/db/:key/:series/:value" do |key,series,value|
  max_age = 60*60 #60 minutes
  o = [series,value]
  @@db.zadd(key,Time.now.to_i,o.to_json)
  puts "Added #{o.to_json}"
  deleted = @@db.zremrangebyscore(key,0,Time.now.to_i - max_age)
  puts "#{deleted} records removed"
end

get "/dash" do
  "nothing"
end
