class Employee < ApplicationRecord
  belongs_to :user
  has_many :holiday_requests
  has_many :subordinates, class_name: "Employee",
                          foreign_key: "manager_id"
 
  belongs_to :manager, class_name: "Employee", optional: true
  
  def name

  end

  def supervisor

  end

end
