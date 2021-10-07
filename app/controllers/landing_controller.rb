class LandingController < ApplicationController
  before_action :authenticate_university!, only: [:indexuniversity]
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
end
