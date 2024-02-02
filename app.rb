require "sinatra"
require "sinatra/reloader"

get("/") do
  erb("<h1>Welcome to Omnicalc 3</h1>")
end


get("/umbrella") do
  erb(:umbrella)
end

get("/process_umbrella") do
  erb(:process_umbrella)
end


get("/message") do
  erb(:message)
end

get("/process_message") do
  erb(:process_message)
end


get("/chat") do
  erb(:chat)
end
