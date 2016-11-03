class SessionsController < ApplicationController
   skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    req.params['client_id'] = ENV['GITHUB_ID']
    req.params['client_secret'] = ENV['SECRET_KEY']
    req.params['code'] = params[:code]
    # Accept json
    req.headers['Accept'] = 'application/json'
  end
  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  redirect_to root_path
  end
end
