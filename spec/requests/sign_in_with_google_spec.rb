require 'rails_helper'

describe 'Sign in with google' do
  context 'when signed up' do
    it do
      google_identity = mock_google_sign_in_identity
      user = sign_up_with_google(google_identity)

      post google_session_path, params: { google_id_token: google_identity.token }
      follow_redirect!

      aggregate_failures do
        expect(response.body).to include('ログインしました')
        expect(response.body).to include(user.name)
        expect(response.body).to include(user.avatar_url)
        expect(response.body).to include('ログアウト')
      end
    end
  end

  context 'when NOT signed up' do
    it do
      google_identity = mock_google_sign_in_identity

      post google_session_path, params: { google_id_token: google_identity.token }
      follow_redirect!

      expect(response.body).to include('ユーザー登録してください')
      expect(response.body).to include('Googleでユーザー登録')
    end
  end

  context 'when signed in' do
    let(:google_identity) { mock_google_sign_in_identity }

    before do
      sign_up_with_google(google_identity)
      post google_session_path, params: { google_id_token: google_identity.token }
    end

    it do
      post google_session_path, params: { google_id_token: google_identity.token }
      follow_redirect!

      expect(response.body).to include('ログインしています')
    end
  end
end
