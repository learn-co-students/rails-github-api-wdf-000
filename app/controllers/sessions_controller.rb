class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post 'https://github.com/login/oauth/access_token' do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body_array = resp.body.split("&")
    session[:token] = body_array[0].split("=")[1]

    response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_body = JSON.parse(response.body)
    session[:username] = user_body["login"]

    redirect_to root_path
  end
end
