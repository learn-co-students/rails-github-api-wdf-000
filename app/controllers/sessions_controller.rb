class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token" do | rep |
      rep.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      rep.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      rep.params['redirect_uri'] = "http://localhost:3000/auth"
      rep.params['code'] = params[:code]
    end
    session[:token] = resp.body.match(/=(\w+)/)[1]
    redirect_to root_path
  end

end
