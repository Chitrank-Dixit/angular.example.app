require 'sinatra'
require "sinatra/json"
require 'sinatra/contrib'
require "sinatra/activerecord"
require './lib/models'

set :environment, ENV['RACK_ENV']
set :show_exceptions, false

error ActiveRecord::RecordNotFound do
  "Not found: " + env['sinatra.error'].message
end

def angular_data_params(*list)
  request.body.rewind # read from beginning of body
  JSON.parse(request.body.read)
end

# Authenticate all at /rest/*, except login and register
before "/rest/*" do
  content_type 'application/json' # content type for all /rest
  return if ["/rest/users/login", "/rest/users/register"].include? request.path
  token = request.env['HTTP_AUTH_TOKEN']
  if token
    @user = User.where(:token => token).first
    return if @user
  end
  halt 403
end

# project_users
get "/rest/project_users/:project_id" do
  project = Project.find(params[:project_id].to_s)
  json project.users
end
post '/rest/project_users' do
  user = User.find(params[:user_id].to_s)
  project = Project.find(params[:project_id].to_s)
  project.users << user
  json({})
end
delete '/rest/project_users' do
  user = User.find(params[:user_id].to_s)
  project = Project.find(params[:project_id].to_s)
  project.users.delete(user)
  json({})
end

# Auth
post "/rest/users/login" do
  token = User.login(angular_data_params['email'].to_s, angular_data_params['password'].to_s)
  if token
    json token
  else
    json({errors: "Wrong credentials"})
  end
end
post "/rest/users/register" do
  record = User.new(angular_data_params)
  if record.valid?
    record.save
    json User.login(angular_data_params['email'], angular_data_params['password'])
  else
    json({errors: record.errors })
  end
end


# projects
get "/rest/projects" do
  json Project.all
end
get "/rest/projects/:id" do
  json Project.find(params[:id].to_s)
end
post "/rest/projects" do 
  record = Project.new(angular_data_params)
  record.user = @user
  if record.valid?
    record.save
    json record
  else
    json({errors: record.errors })
  end
end
put "/rest/projects/:id" do
  record = Project.find(params[:id].to_s)
  if record.update_attributes(angular_data_params)
    json record
  else
    json({errors: record.errors })
  end
end
delete "/rest/projects/:id" do
  record = Project.find(params[:id].to_s)
  record.delete
  json record
end

# catch all
get '*' do
  erb :index
end
