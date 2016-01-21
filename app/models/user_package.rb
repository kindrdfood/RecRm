# == Schema Information
#
# Table name: user_packages
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  package_id      :integer
#  purchase_date   :date
#  expiration_date :date
#

class UserPackage < ActiveRecord::Base
  belongs_to :user
  belongs_to :package
  after_create :generate_appointments, if: :should_generate_appointments?
  has_one :purchase, as: :purchasable

  private

  def generate_appointments
    
    # Get number of full and half sessions in package
    num_halfs = self.package.num_half_appointments
    num_fulls = self.package.num_full_appointments

     # Create new appointment with host, duration, status, and registration stage 2
    num_halfs.times do |i|
      Appointment.create(appointment_host_id: self.user.id, status: "Unused Package Session", duration: 30, registration_stage: 2)
    end
    num_fulls.times do |i|
      Appointment.create(appointment_host_id: self.user.id, status: "Unused Package Session", duration: 60, registration_stage: 2)
    end
    
  end

  def should_generate_appointments?

    true

  end

end
