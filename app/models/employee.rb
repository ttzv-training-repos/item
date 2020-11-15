class Employee < ApplicationRecord
  after_create :ensure_employee_has_inbox

  belongs_to :user
  has_many :holiday_requests
  has_many :subordinates, class_name: "Employee",
                          foreign_key: "manager_id"
 
  belongs_to :manager, class_name: "Employee", optional: true
  has_one :inbox
  def name

  end

  def supervisor

  end

  private

  def ensure_employee_has_inbox
    self.create_inbox unless self.inbox
  end

end
