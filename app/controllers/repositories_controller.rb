class RepositoriesController < ApplicationController

  def index
  	@username = session[:username]
  	resp = Faraday.get("https://api.github.com/users/#{@username}/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    	req.headers[ 'Accept'] = 'application/json'
    end
    
    @repos = JSON.parse(resp.body)
    # byebug
  end

  def create
  	response = Faraday.post("https://api.github.com/user/repos") do |req|
  		req.headers['Authorization'] = "token #{session[:token]}"
    	req.headers[ 'Accept'] = 'application/json'
  		req.params['name'] = params[:name].to_json
  	end

  	redirect_to root_url
  end
end
