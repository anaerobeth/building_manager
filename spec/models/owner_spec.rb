require 'spec_helper'

describe Owner do

  it { should have_valid(:first_name).when('Diane', 'Susan') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Day', 'Stone') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when('dave@gmail.com') }
  it { should_not have_valid(:email).when(nil, '', 'bananas') }



end
