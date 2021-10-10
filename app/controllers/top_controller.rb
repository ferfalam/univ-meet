class TopController < ApplicationController
  before_action :authenticate
  def index
  end

  private
  def authenticate
    if current_university
      redirect_to "/universities/landing"
    elsif current_student
      redirect_to "/students/landing"
    end
  end
  
end
