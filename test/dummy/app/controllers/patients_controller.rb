class PatientsController < ApplicationController

  respond_to :html, :json

  def index
    @patients = Patient.all

    respond_with(@patients)
  end

  def show
    puts "xxxx"
  end
  
  def new
  end
  
  def edit
  end

  def update
  end
  
  def create
  end

  def delete
  end

end