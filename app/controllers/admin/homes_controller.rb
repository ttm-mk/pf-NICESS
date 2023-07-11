class Admin::HomesController < ApplicationController
  before_action :authentication_admin!
  
def top
  @users = User.all
end
  
end

