module EmployeesHelper

  def manager_params
    params.require(:employee).permit(:manager_id)
  end
end
