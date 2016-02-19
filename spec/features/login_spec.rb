describe "the login process" do
  it "logs me in" do
    visit '/'
    click_link('Sign In')
    fill_in 'Email', with: 'evrysteptestuser@gmail.com'
    click_button('Next')
    fill_in 'Passwd', with: 'testevrysteptest'
    click_button('Sign in')
    click_button('Allow')
    expect(page).to have_content "Successfully authenticated from Google account."
  end
end