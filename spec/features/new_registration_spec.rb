require 'rails_helper'

describe 'new registration flow' do

  before :all do
    Capybara.current_driver = :webkit
    @url_prefix = 'http://localhost:3000'
  end

  before :each do
    @user_email = "test_user_#{Time.now.to_i}@test.com"
    @user_password = 'test_user_password'
  end

  def fill_in_ckeditor(locator, opts)
    content = opts.fetch(:with).to_json
    page.execute_script <<-SCRIPT
    CKEDITOR.instances['#{locator}'].setData(#{content});
    $('textarea##{locator}').text(#{content});
    SCRIPT
  end

  it 'can not create new job even if the new registration completes' do
    visit "#{@url_prefix}/users/sign_up"

    fill_in 'user_email', :with => @user_email
    fill_in 'user_password', :with => @user_password
    fill_in 'user_password_confirmation', :with => @user_password
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')

    click_link 'Post'
    expect(page).to have_content('You need bind to one team or company first')

    click_link 'Admin'
    expect(page).to have_content('Bind to Org')

    fill_in 'org_name', :with => 'Test Org'
    fill_in 'org_link', :with => 'testorg.url.com'
    fill_in_ckeditor 'org_desc', :with => 'desc'
    click_button 'Save'

    expect(page).to have_content('Org was successfully bound.')

    click_link 'Post'
    expect(page).to have_selector('#new_job')

    job_title = "Test Developer #{Time.now.to_i}"

    fill_in 'job_title', :with => job_title
    fill_in_ckeditor 'job_jd', :with => 'nothing'
    click_button 'Post Job'

    visit @url_prefix
    expect(page).to have_content(job_title)
  end
end