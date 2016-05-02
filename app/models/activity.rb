class Activity < ActiveRecord::Base
  include EnumHelper

  @accessible_attrs = column_names.reject{|x| x == "id"}.map(&:to_sym)
  attr_accessible(*@accessible_attrs)
  attr_accessible :followed_user, :item

  belongs_to :followed_user, class_name: "User"
  belongs_to :item, polymorphic: true

  enum(:action, :gave_props, :accepted_credit_invite, :commented_on, :created_reel, :followed_item)

  class << self
    # Overwrite the .create method to work with enum helper (for now)
    def create(opts = {})
      value = opts[:action]
      opts[:action] = action_states.invert[value] if value.is_a?(Symbol)
      super
    end
  end


  def action
    self.class.action_states[self[:action]]
  end
end

# == Schema Information
#
# Table name: activities
#
#  id               :integer          not null, primary key
#  action           :integer
#  followed_user_id :integer
#  item_id          :integer
#  item_type        :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
