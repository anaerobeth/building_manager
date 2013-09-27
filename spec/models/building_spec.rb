require 'spec_helper'

describe Building do
  it { should have_valid(:street_address).when('15 Kneeland', '51 Linden') }
  it { should_not have_valid(:street_address).when(nil, '') }

  it { should have_valid(:city).when('Boston', 'Allston') }
  it { should_not have_valid(:city).when(nil, '') }

  it { should have_valid(:state).when('MA', 'NH') }
  it { should_not have_valid(:state).when(nil, 'bananas', '') }

  it { should have_valid(:postal_code).when('32111', '51901', '02111') }
  it { should_not have_valid(:postal_code).when(nil, '', '123456', '1', '-1') }

end
