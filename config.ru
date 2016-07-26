require 'sinatra'
require "sinatra/param"
require "json"

set :raise_sinatra_param_exceptions, true

disable :show_exceptions
disable :raise_errors

error Sinatra::Param::InvalidParameterError do
  status 422
  {error: "#{env['sinatra.error'].param} is invalid/blank"}.to_json
end

error 500 do
  "Shit just got real bro"
end

use Rack::Auth::Basic do |username, password|
  username == 'admin@teachable.com' && password == 'secret'
end

get "/" do
  File.open("./test-users.json").read
end

post "/" do
  param :name, String, required: true
  param :email, String, required: true, format: /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/

  contents = File.open("./test-users.json").read
  parsed_contents = JSON.parse(contents)
  File.delete("./test-users.json")
  parsed_contents["guests"] << {"email": params["email"], "name": params["name"]}
  File.open("./test-users.json", "w+") do |f|
    f.puts JSON.pretty_generate(parsed_contents)
  end

  "#{params['name']} now signed up with #{params['email']}"
end

delete "/:email" do
  param :email, String, required: true

  contents = File.open("./test-users.json").read
  parsed_contents = JSON.parse(contents)
  File.delete("./test-users.json")
  parsed_contents["guests"].delete_if {|guest| guest["email"] == params["email"]}
  File.open("./test-users.json", "w+") do |f|
    f.puts JSON.pretty_generate(parsed_contents)
  end
  "#{params['email']}has been removed successfully".to_json
end

run Sinatra::Application
