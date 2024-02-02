require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  erb("<h1>Welcome to Omnicalc 3</h1>")
end


get("/umbrella") do
  erb(:umbrella)
end

get("/process_umbrella") do

  @user_loc = params[:user_loc]

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@user_loc}&key=#{ENV.fetch(GMAPS_KEY)}"
  raw_gmaps_data = HTTP.get(gmaps_url)
  parsed_gmaps_data = JSON.parse(raw_gmaps_data)
  @longitude = parsed_gmaps_data["results"][0]["geometry"]["location"]["lng"]
  @latitude = parsed_gmaps_data["results"][0]["geometry"]["location"]["lat"]
  erb(:process_umbrella)
end


get("/message") do
  erb(:message)
end

get("/process_single_message") do
  erb(:process_single_message)
end


get("/chat") do
  erb(:chat)
end
