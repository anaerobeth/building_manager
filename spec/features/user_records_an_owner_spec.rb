require 'spec_helper'

feature 'Record an Owner', %Q{
  As a real estate associate
  I want to record a building owner
  So that I can keep track of our relationships with owners
  } do
  # Acceptance Criteria:

  # I must specify a first name, last name, and email address
  # I can optionally specify a company name
  # If I do not specify the required information, I am presented with errors
  # If I specify the required information, the owner is recorded and I am redirected to enter another new owner

  # Also covers:
  # As a real estate associate
  # I want to match an owner of a building
  # So that I can refer back to pertinent information
  # Acceptance Criteria:

  # When recording a building, I want to optionally associate the building with its rightful owner.
  # If I delete an owner, the owner and its primary key should no longer be associated with any properties.

  scenario 'enters information in the required format' do
    prev_count = Owner.count
    visit new_owner_url
    fill_in 'First name', with: 'Dave '
    fill_in 'Last name', with: 'Thomas'
    fill_in 'Email', with: 'dave@gmail.com'
    fill_in 'Company name', with: 'Trump Realty'

    click_button 'Record'
    expect(page).to have_content('Owner was successfully recorded')
    expect(Owner.count).to eql(prev_count + 1)
  end

  scenario 'does not enter information in the required format' do
    prev_count = Owner.count
    visit new_building_url

    click_button 'Record'
    expect(page).to_not have_content('Owner was successfully recorded')
    expect(Owner.count).to eql(prev_count)
  end

  scenario 'recording building adds association with owner' do
    owner = Owner.create(first_name: 'Dave', last_name: 'Thomas',
      email: 'dave@gmail.com')

    prev_count = Building.count
    visit new_building_url
    fill_in 'Street address', with: '15 Kneeland'
    fill_in 'City', with: 'Boston'
    fill_in 'State', with: 'MA'
    fill_in 'Postal code', with: '42111'
    fill_in 'Description', with: 'Luxury Loft'
    select 'Dave'
    click_button 'Record'

    expect(page).to have_content('Building was successfully recorded')
    expect(Building.count).to eql(prev_count + 1)
    expect(Building.last.owner_id).to eql(owner.id)
  end

  scenario 'deleting an owner removes association with any properties' do
    owner = Owner.create(first_name: 'Dave', last_name: 'Thomas', email: 'dave@gmail.com')

    prev_owner_count = Owner.count
    building = Building.new(street_address: '15 Kneeland',
    city: 'Boston',
    state: 'MA',
    postal_code: 42111,
    description: 'Luxury Loft',
    owner_id: owner.id)

    building.save!
    owned_buildings_count = Building.where('owner_id = ?', owner.id).count
    expect(owned_buildings_count).to eql(1)

    visit owners_path
    click_button 'Delete'

    expect(page).to have_content('Owner was successfully deleted')
    expect(Owner.count).to eql(prev_owner_count - 1)
    prev_owned_buildings_count = Building.where('owner_id = ?', owner.id).count
    expect(prev_owned_buildings_count).to eql(0)
   end

end