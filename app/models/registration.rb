class Registration < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :user_id, :event_id, :availability_confirmation, :payment_required

  # Associations
  belongs_to :event
  belongs_to :user

  # Validations
  validates :availability_confirmation, :acceptance => {:message => "You must confirm that you are available for the event."}
  validates :name, :email, length: {maximum: 50, message: "is too long"}
  validates :phone, length: {maximum: 20, message: "is too long"}
  validates :name, :email, :phone, :presence => {:message => "cannot be blank"}

end

# == Schema Information
#
# Table name: registrations
#
#  id                        :integer          not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  name                      :string(255)
#  email                     :string(255)
#  phone                     :string(255)
#  user_id                   :integer
#  event_id                  :integer
#  availability_confirmation :boolean
#
