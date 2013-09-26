require 'spec_helper'

feature 'Record a building', %Q{
  As a real estate associate
 I want to record a building
 So that I can refer back to pertinent information
} do

  #   Acceptance Criteria:

  # I must specify a street address, city, state, and postal code
  # Only US states can be specified
  # I can optionally specify a description of the building
  # If I enter all of the required information in the required format, the building is recorded.
  # If I do not specify all of the required information in the required formats, the building is not recorded and I am presented with errors
  # Upon successfully creating a building, I am redirected so that I can record another building.


  scenario 'enters information in the required format' do
    prev_count = Building.count
    visit new_building_url
    fill_in 'Street address', with: '15 Kneeland'
    fill_in 'City', with: 'Boston'
    fill_in 'State', with: 'MA'
    fill_in 'Postal code', with: '42111'
    fill_in 'Description', with: 'Luxury Loft'

    click_button 'Record'
    expect(page).to have_content('Building was successfully recorded')
    expect(Building.count).to eql(prev_count + 1)
  end

  scenario 'does not enter information in the required format' do
  end

end