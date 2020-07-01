class OfficesController < ApplicationController
  include OfficesHelper
  def index
    @offices = Office.all
  end

  def new
    @office = Office.new
  end

  def create
    @office = Office.new(office_params)
    @office.save
    redirect_to offices_path
  end

  def edit
    @office = Office.find(params[:id])
  end

  def update
    @office = Office.find(params[:id]).update(office_params)
    redirect_to offices_path
  end

  def destroy
    Office.find(params[:id]).destroy
  end

end
