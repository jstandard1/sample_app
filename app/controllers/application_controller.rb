class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  #Force signout to prevent cross-site redirect attacks
  def handle_unverified_request
  	sign_out
  	super
  end

  def update
  	@user = User.find(params[:id])
  end
end
