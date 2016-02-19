describe "the login process" do

  around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  it "logs me in" do
    visit '/'

    login_via_google
    expect(page).to have_content "Successfully authenticated from Google account."

    create_reel

    add_media("Image", "test.jpeg")
    expect(page).to have_content "Image added!"

    add_media('Video', "test.mp4")
    expect(page).to have_content "Your video has been uploaded!"

    # Add story
    click_link("ADD MEDIA")
    click_link("Story")
    attach_file('story_photo', Rails.root.to_path + "/spec/fixtures/test.jpeg")
    fill_in 'story_title', with: "Test Story"
    fill_in_ckeditor('story_body', with: "Test story body")
    click_button('Save')

    expect(page).to have_content "Test Reel"
  end
end

def fill_in_ckeditor(locator, opts)
  content = opts.fetch(:with).to_json
  page.execute_script <<-SCRIPT
    CKEDITOR.instances['#{locator}'].setData(#{content});
    $('textarea##{locator}').text(#{content});
  SCRIPT
end

def login_via_google
  click_link('Sign In')
  fill_in 'Email', with: 'evrysteptestuser@gmail.com'
  click_button('Next')
  fill_in 'Passwd', with: 'testevrysteptest'
  click_button('Sign in')
  click_button('Allow')
end

def create_reel
  click_link("CREATE REEL")
  fill_in 'reel_name', :with => 'Test Reel'
  fill_in 'reel_description', :with => 'Test reel description'
  click_button('Save')
end

def add_media(link, fixture)
  click_link("ADD MEDIA")
  click_link(link)
  page.execute_script("$('#video_file').toggle();")
  attach_file('video_file', Rails.root.to_path + "/spec/fixtures/" + fixture)
  fill_in 'video_description', with: "Test description"
  click_button('submit-media')
end