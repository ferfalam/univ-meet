class LandingController < ApplicationController
  before_action :authenticate_university!, only: [:indexuniversity]
  before_action :valid_account
  def indexuniversity
    if current_university.admin
      @data = {
        universities: University.all
      }
    else
      @data = {
        fields: current_university.fields,
        students: current_university.students,
        requests: current_university.requests
      }
    end
  end


  private
  def valid_account
    if current_university && !current_university.valid_account
      flash[:notice] = "Votre compte n'est pas encore valide, veuillez patienter"
      redirect_to "/universities/edit"
    elsif current_student && !current_student.valid_account
      flash[:notice] = "Votre compte n'est pas encore valide, veuillez patienter"
      redirect_to "/students/edit"
    end    
  end
end
