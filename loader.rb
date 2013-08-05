require 'rubygems'
require 'redis'
require 'json'
require 'pp'

ENV['REDIS_URL'] = 'redis://redistogo:130e70de63de375e7fe12fe6654a4e3c@grouper.redistogo.com:9791/'

db = Redis.new

key = "jai"
series = %w|sa sb sc|
entries = 200

db.del key

i = 0
x = 0
while x < entries
  data = [series[rand(3)],rand(120)]
  now = Time.now.to_i - rand(300)
  puts "Adding #{now} : #{data.to_json}"
  db.zadd(key,now,data.to_json)
  i += 1  
end

sleep 120

db.del key
