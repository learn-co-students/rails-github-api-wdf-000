class RepositoriesController < ApplicationController

  def index
    response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @user = current_user
    @respositories = JSON.parse(response.body)
  end

  def create
    response = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {name: "#{params[:name]}"}.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    redirect_to root_path
  end

end
