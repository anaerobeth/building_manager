class Owner < ActiveRecord::Base

  validates_presence_of :first_name
  validates_presence_of :last_name

  validates_format_of :email,
    :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
    :message => "should be a valid email address"

end
