require 'spec_helper'

describe Tenant do
  it { should have_valid(:first_name).when('Ron', 'Susan') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Charles', 'Stone') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when('pippa@gmail.com') }
  it { should_not have_valid(:email).when(nil, '', 'bananas') }

end
