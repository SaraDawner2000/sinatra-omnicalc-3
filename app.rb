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

post("/process_umbrella") do

  @user_loc = params[:user_loc]

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@user_loc}&key=#{ENV.fetch("GMAPS_KEY")}"
  raw_gmaps_data = HTTP.get(gmaps_url)
  parsed_gmaps_data = JSON.parse(raw_gmaps_data)
  @longitude = parsed_gmaps_data["results"][0]["geometry"]["location"]["lng"]
  @latitude = parsed_gmaps_data["results"][0]["geometry"]["location"]["lat"]

  pirate_weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{@latitude},#{@longitude}"
  raw_pirate_weather_data = HTTP.get(pirate_weather_url)
  parsed_pirate_weather_data = JSON.parse(raw_pirate_weather_data)
  @current_temp = parsed_pirate_weather_data["currently"]["temperature"]

  
  hourly_hash = parsed_pirate_weather_data.fetch("hourly", false)
  hourly_data_array = hourly_hash.fetch("data")
  next_twelve_hours = hourly_data_array[1..12]
  @current_summary = hourly_hash.fetch("summary")

  precip_prob_threshold = 0.10
  @any_precipitation = false
  next_twelve_hours.each do |hour_hash|
    precip_prob = hour_hash.fetch("precipProbability")
  
    if precip_prob > precip_prob_threshold
      @any_precipitation = true
    end
  end
  erb(:process_umbrella)
end


get("/message") do
  erb(:message)
end

post("/process_single_message") do
  erb(:process_single_message)
end


get("/chat") do
  erb(:chat)
end
