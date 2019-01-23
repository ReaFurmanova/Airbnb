class ApplicationController < ActionController::Base
  include Clearance::Controller

  # before_action :require_login
  # this function is because if I want to get to for example profile page i must to do log in
  # case: I can not to go to welcome if I have this in the beginnig(Matt shows me)

end
