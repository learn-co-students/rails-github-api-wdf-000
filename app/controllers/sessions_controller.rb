class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      # req.params['v'] = 'application/vnd.github.v3+json'
      # req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:8888/auth"
      req.params['code'] = params[:code]
    end

    # binding.pry
    # body = JSON.parse(resp.body)
    session[:token] = resp.body.match(/\=(\w*)\&/).captures[0]

    username = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = resp.body.match(/\=(\w*)\&/).captures[0]
    end
    # binding.pry
    session[:username] = JSON.parse(username.body)["login"]
    redirect_to root_path
  end
end
