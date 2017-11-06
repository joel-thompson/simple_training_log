require "rails_helper"
require "spec_helper"

RSpec.describe "Micropost interface", :type => :request do

  fixtures :users
  fixtures :microposts
  # fixtures :test_image

  before do
    @user = users(:michael)
    # picture = fixture_file_upload('spec/fixtures/test_image.png', 'image/png')
  end

  it "logs in and makes a microposts and get redirected to root" do
    # log in aser user
    get "/"
    expect(response).to render_template(:index)
    get "/login"
    expect(response).to render_template(:new)
    post '/login', params: { session: {email: "michael@example.com" , password: "password"} }
    expect(response).to redirect_to(assigns(:user))
    follow_redirect!
    expect(response).to render_template(:show)

    # creates a micropost with an image
    get "/"
    picture = fixture_file_upload('spec/fixtures/test_image.png', 'image/png')
    expect{
      post '/microposts', params: { micropost: { content: "foo", picture: picture } }
    }.to change{Micropost.count}.by(1)
    expect(response).to redirect_to('/')
    follow_redirect!
    expect(response).to render_template(:index)

  end

end
