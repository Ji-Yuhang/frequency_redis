require "redis"
require "sinatra"
url = "redis://redis:6380/2"
$redis = Redis.new url: url
[5, 4, 3, 2, 1].each do |l|
  words = File.read("./collins#{l}.txt").lines.map(&:strip)
  words.each do |word|
    $redis.set(word, l)
  end
end
