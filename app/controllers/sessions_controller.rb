class SessionsController < ApplicationController
	skip_before_action :authenticate_user, only: :create
  def create
  	resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'
	    req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
	    req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['scope'] = "user repo"
	    req.params['code'] = params[:code]
	  end



	  hash = JSON.parse(resp.body)
    session[:token] = hash["access_token"]

    user_response = Faraday.get("https://api.github.com/user") do |req|
    	 req.headers['Authorization'] = "token #{session[:token]}"
    	 req.headers[ 'Accept'] = 'application/json'
    end
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
    # byebug
    redirect_to '/'
  end
end