class Tenant < ActiveRecord::Base

  validates_presence_of :first_name
  validates_presence_of :last_name

  validates_format_of :email,
    with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i,
    :message => "should be a valid email address"

  validates_numericality_of :building_id,
    only_integers: true,
    greater_than_or_equal_to: 1

  belongs_to :building,
    inverse_of: :tenants

  has_one :owner,
    through: :buildings,
    inverse_of: :tenants

end
