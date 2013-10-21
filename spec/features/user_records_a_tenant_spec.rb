require 'spec_helper'

feature 'Record a Tenant', %Q{
  As an owner
  I want to add a tenant
  So that I can keep track of who is renting in my building
  } do

  # Acceptance Criteria:

  # * I must specify a first name, last name, building they're renting in,
  #   and valid email address.
  # * If the tenant information is valid, the tenant is associated with the
  #   building. The information is persisted.
  # * If the tenant information is invalid, an error message is supplied so
  #   the landlord can fix the entry. The information is not persisted.

  # Also covers:
  # As an owner
  # I want to view all of my tenants
  # So that I can have a roster of those renting in my building

  # Acceptance Criteria:

  # * There is a page that lists all of my tenants sorted by last name and
  # first name.
  # * I can see where each tenant lives and what their email address is.


  scenario 'enters information in the required format' do

    prev_count = Tenant.count
    visit new_tenant_url
    fill_in 'First name', with: 'Diane '
    fill_in 'Last name', with: 'Thomas'
    fill_in 'Email', with: 'diane@gmail.com'
    fill_in 'Building', with: 2

    click_button 'Record'
    expect(page).to have_content('Tenant was successfully recorded')
    expect(Tenant.count).to eql(prev_count + 1)

  end

  scenario 'does not enter information in the required format' do
    prev_count = Tenant.count
    visit new_tenant_url

    click_button 'Record'
    expect(page).to_not have_content('Tenant was successfully recorded')
    expect(Tenant.count).to eql(prev_count)
  end

  scenario 'tenant information is listed' do
    owner = Owner.create(first_name: 'Dave', last_name: 'Thomas', email: 'dave@gmail.com')
    building = Building.create(street_address: '15 Kneeland', city: 'Boston',
      state: 'MA', postal_code: 42111, description: 'Luxury Loft',
      owner_id: owner.id)

    tenant = Tenant.create(first_name: 'Beth', last_name: 'Tenorio',
      email: 'beth@gmail.com', building_id: building.id)

    visit tenants_path
    expect(page).to have_content("List of tenants")
    expect(page).to have_content("Tenorio")
    expect(page).to have_content("beth@gmail.com")
  end

  scenario 'tenant is evicted' do
    tenant = Tenant.create(first_name: 'Beth', last_name: 'Tenorio',
      email: 'beth@gmail.com', building_id: 2)
    Tenant.create(first_name: 'Emily', last_name: 'Lopez',
      email: 'beth2@gmail.com', building_id: 3)
    prev_tenant_count = Tenant.count

    visit tenants_path

    expect(page).to have_content("List of tenants")
    expect(page).to have_content("Tenorio")
    expect(page).to have_content("beth@gmail.com")
    within(".tenant_#{tenant.id}") do
      click_button 'Delete'
    end

    expect(page).to have_content('Tenant was successfully deleted')
    expect(Tenant.count).to eql(prev_tenant_count - 1)

    visit tenants_path
    expect(page).to have_content("List of tenants")
    expect(page).to_not have_content("Tenorio")
    expect(page).to_not have_content("beth@gmail.com")
  end

end