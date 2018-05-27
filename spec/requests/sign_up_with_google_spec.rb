require 'rails_helper'

xdescribe 'Sign up with google' do
  it do
    google_identity = mock_google_sign_in_identity

    post google_sign_up_path, params: { google_id_token: google_identity.token }, xhr: true
    follow_turbolinks_visit!

    expect(response.body).to include(google_identity.name)
    expect(response.body).to include(google_identity.avatar_url)
  end
end
