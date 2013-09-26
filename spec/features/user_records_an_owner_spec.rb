require 'spec_helper'

feature 'Record a building', %Q{
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