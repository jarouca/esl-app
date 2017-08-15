require 'rails_helper'

feature 'user deletes their account' do
  # As an authenticated user
  # I want to delete my profile
  # So that my information is no longer retained by the app
  #
  # Acceptance criteria:
  # - I must be able to access the 'delete profile' link from the 'edit profile' page
  # - I must be given notification that my deletion was successful

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user deletes account' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'Edit Profile'
    click_link 'Cancel my account'

    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
  end

  scenario 'unathenticated user unable to delete account' do
    visit 'users/sign_in'

    expect(page).to_not have_content('Cancel my account')
  end
end
