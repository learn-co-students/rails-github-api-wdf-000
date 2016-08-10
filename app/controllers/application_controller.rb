class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_action :authenticate_user
  

  ENV['GITHUB_CLIENT_ID'] = 'b5b8db3e12f9679c6b1e'
	ENV['GITHUB_SECRET'] = 'ade2774626005b50d32ce103fc6816b660187fe8'

  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT_ID']
      auth_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=repo"
      # byebug
      redirect_to auth_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
