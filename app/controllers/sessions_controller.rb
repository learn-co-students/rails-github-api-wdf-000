class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.headers['Accept'] = 'application/json'
      req.params['code'] = params[:code]
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    user_response = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    user_body = JSON.parse(user_response.body)
    session[:username] = user_body["login"] 
    redirect_to root_path
  end
end
