class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create





  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.headers['Accept'] = 'application/json'
      req.params['code'] = params[:code]
    end
      repo_body = JSON.parse(resp.body)
      session[:token] = repo_body["access_token"]
      response = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
      body = JSON.parse(response.body)
      session[:username] = body["login"]
      redirect_to root_path
  end



  def clear_session
    session.clear
  end



end
