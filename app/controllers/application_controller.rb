class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  #Force signout to prevent cross-site redirect attacks
  def handle_unverified_request
  	sign_out
  	super
  end
end
