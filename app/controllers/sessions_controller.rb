class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
       req.params['client_id'] = Pusher.key
       req.params['client_secret'] = Pusher.secret
       req.params['grant_type'] = 'authorization_code'
       req.params['redirect_uri'] = "http://localhost:3000/auth"
       req.params['code'] = params[:code]
       req.headers['Accept'] = 'application/json'
     end
     @body = JSON.parse(response.body)
     session[:token] = @body["access_token"]
     redirect_to root_path
  end
end
