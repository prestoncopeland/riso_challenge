require 'sinatra'
require "sinatra/param"
require "json"
require "erb"

set :raise_sinatra_param_exceptions, true

disable :show_exceptions
disable :raise_errors

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin@teachable.com', 'secret']
  end
end

error Sinatra::Param::InvalidParameterError do
  status 422
  {error: "#{env['sinatra.error'].param} is invalid/blank"}.to_json
end

error 500 do
  "I have been instructed to inform you that 'Shit just got real.'"
end

get "/homepage" do
  erb :homepage
end

##QUERY THE USERS LIST
get "/" do
  protected!
  erb :homepage
end

##ADD A NEW USER
post "/" do
  protected!
  param :name, String, required: true
  param :email, String, required: true, format: /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/

  contents = File.open("public/test-users.json").read
  parsed_contents = JSON.parse(contents)
  File.delete("public/test-users.json")
  parsed_contents["guests"] << {"email": params["email"], "name": params["name"]}
  File.open("public/test-users.json", "w+") do |f|
    f.puts JSON.pretty_generate(parsed_contents)
  end

  @success_msg = "Thank you for registering #{params['name']}"
  erb :homepage
end

##DELETE A USER
delete "/:email" do
  protected!
  param :email, String, required: true

  contents = File.open("public/test-users.json").read
  parsed_contents = JSON.parse(contents)
  File.delete("public/test-users.json")
  parsed_contents["guests"].delete_if {|guest| guest["email"] == params["email"]}
  File.open("public/test-users.json", "w+") do |f|
    f.puts JSON.pretty_generate(parsed_contents)
  end

  @success_msg = "#{params['email']}has been removed successfully".to_json
  erb :homepage
end

run Sinatra::Application