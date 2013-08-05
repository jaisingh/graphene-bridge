require 'rubygems'
require 'redis'
require 'json'
require 'pp'

trap("SIGINT") do
  exit 0
end

SPEED_LOAD = false

ENV['REDIS_URL'] = 'redis://redistogo:130e70de63de375e7fe12fe6654a4e3c@grouper.redistogo.com:9791/'

db = Redis.new

key = "jai"
series = %w|sa sb sc|
entries = 200

deleted = db.zremrangebyscore(key,0,Time.now.to_i - 3600)
puts "#{deleted} records removed"
sleep 3
i = 0
x = 0
time_spread = SPEED_LOAD ? 300 : 1

while x < entries
  data = [series[rand(3)],rand(120)]
  now = Time.now.to_i - time_spread
  puts "Adding #{now} : #{data.to_json}"
  db.zadd(key,now,data.to_json)
  i += 1
  sleep 1 unless SPEED_LOAD  
end

sleep 120

db.del key
