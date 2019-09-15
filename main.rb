require 'redis'
require 'sinatra'
$redis = Redis.new url: ENV['REDIS_URL']
get '/frequency/:word' do
  $redis.get params[:word]
end
get '/frequency/:word/:num' do
  $redis.set params[:word], params[:num]
  $redis.get params[:word]
end

get '/frequency_batch/:words' do
  puts params
  words = params[:words].split(",")
  words.map do |w|
      {
        w: w,
        f: $redis.get(w)
      }
  end.to_json
end
