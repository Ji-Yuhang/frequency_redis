require "redis"
require "sinatra"
url = ENV["REDIS_URL"]
puts ENV
puts url
$redis = Redis.new url: url
get "/frequency/:word" do
  $redis.get params[:word]
end
get "/frequency/:word/:num" do
  $redis.set params[:word], params[:num]
  $redis.get params[:word]
end

post "/frequency/parse" do
  html = params[:html]
  filter = params[:filter]
  puts html
  words = html.split(/\W+/).map(&:strip)
  words = words.map do |w|
    {
      w: w,
      f: $redis.get(w),
    }
  end
  unless filter.nil?
    words = words.select { |obj| obj[:f].nil? || obj[:f] < filter }
  end
  words.to_json
end

get "/frequency_batch/:words" do
  puts params
  words = params[:words].split(",")
  words.map do |w|
    {
      w: w,
      f: $redis.get(w),
    }
  end.to_json
end
