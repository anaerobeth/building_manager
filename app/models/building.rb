class Building < ActiveRecord::Base
VALID_STATES = [
  "AL",
  "AK",
  "AZ",
  "AR",
  "CA",
  "CO",
  "CT",
  "DE",
  "FL",
  "GA",
  "HI",
  "ID",
  "IL",
  "IN",
  "IA",
  "KS",
  "KY",
  "LA",
  "ME",
  "MD",
  "MA",
  "MI",
  "MN",
  "MS",
  "MO",
  "MT",
  "NE",
  "NV",
  "NH",
  "NJ",
  "NM",
  "NY",
  "NC",
  "ND",
  "OH",
  "OK",
  "OR",
  "PA",
  "RI",
  "SC",
  "SD",
  "TN",
  "TX",
  "UT",
  "VT",
  "VA",
  "WA",
  "WV",
  "WI",
  "WY"

]
  validates_presence_of :street_address
  validates_presence_of :city

  validates_inclusion_of :state,
    in: VALID_STATES

  validates_format_of :postal_code,
    :with => /\A\d{5}\z/,
    :message => "should be 12345"

  validates_length_of :postal_code,
    :is => 5


  belongs_to :owner,
    inverse_of: :building

  has_many :tenants,
    inverse_of: :building

end
