#Code bloew this is from Anilist
require 'uri'
require 'net/http'

url = URI("https://anilistmikilior1v1.p.rapidapi.com/getAnimeList")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/x-www-form-urlencoded'
request["X-RapidAPI-Key"] = '46ec121875mshb238fcd35960075p1df0f2jsn51b1e3cfad83'
request["X-RapidAPI-Host"] = 'Anilistmikilior1V1.p.rapidapi.com'
request.body = "userId=%3CREQUIRED%3E"

response = http.request(request)
puts response.read_body
#Code above is from Anilist


require "sinatra"
require "sinatra/reloader"


get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end
