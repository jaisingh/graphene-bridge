require 'rubygems'
require 'redis'
require 'json'
require 'pp'

trap("SIGINT") do
  exit 0
end

SPEED_LOAD = false

db = Redis.new

key = "jai"
series = %w|sa sb sc|
entries = SPEED_LOAD ? 200 : 60000

i = 0
x = 0
time_spread = SPEED_LOAD ? 300 : 1

while x < entries
  data = [series[rand(3)],rand(120)]
  now = Time.now.to_i - time_spread
  puts "Adding #{now} : #{data.to_json}"
  db.zadd(key,now,data.to_json)
  i += 1
  unless SPEED_LOAD
    puts "This loop will continue forever, ctrl-c to exit"
    deleted = db.zremrangebyscore(key,0,Time.now.to_i - 300)
    puts "#{deleted} records removed"
    sleep 1
  end 
end

puts "ctrl-c to prevent db deletion"
sleep 60

db.del key
