class Owner < ActiveRecord::Base

  validates_presence_of :first_name
  validates_presence_of :last_name

  validates_format_of :email,
    with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i,
    :message => "should be a valid email address"


  has_many :buildings,
    inverse_of: :owner,
    dependent: :nullify

  has_many :tenants,
    through: :buildings,
    inverse_of: :owner


end
