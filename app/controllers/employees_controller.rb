class EmployeesController < ApplicationController
  include EmployeesHelper
  def index
    
  end

  def edit
    @employee = Employee.find(params[:id])
    @subordinates = @employee.subordinates
    @manager = @employee.manager
    filtered_ids = @subordinates.map { |s| s.id } #subordinate cant be a manager
    filtered_ids << params[:id] #add current employee id to filtered ids
    @employee_options = Employee.where.not(id: filtered_ids).map do |e|
      [e.user.email, e.id] 
    end
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update(manager_params)
    redirect_to root_path
  end
end
