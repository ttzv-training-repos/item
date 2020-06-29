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

end
