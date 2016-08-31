class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
       req.body = {"client_id"=>"9e2a6b4fc5e0c8c87a3a", "client_secret"=>"c9c03b76541331b7a478e932c7a8001cda72912f", "code"=>"20"}
       req.headers = {'Accept'=>'application/json'}
     end
     session[:token] = JSON.parse(resp.body)['access_token']
     un = Faraday.get('https://api.github.com/user') do |req|
       req.headers = {'Authorization'=>"token #{session[:token]}"}
     end
     session[:username] = JSON.parse(un.body)['login']
     redirect_to root_path
   end

end
