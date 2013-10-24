class DoctorsController < ApplicationController

  respond_to :html, :json

  def index
    @doctors = Doctor.all

    respond_with(@doctors)
  end

  def show
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