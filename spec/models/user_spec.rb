require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_for_facebook_oauth' do
    let(:access_token) do
      double(
        :access_token,
        provider: 'facebook',
        info: double(email: 'boriska000@gmail.com'),
        extra: double(raw_info: double(id: '1703636318'))
            )
    end
    context 'when user is not found' do
      it 'returns newly created user' do
        user = User.find_for_facebook_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq 'boriska000@gmail.com'
      end
    end

    context 'when user is found via email' do
      let!(:existing_user) { create(:user, email: 'boriska000@gmail.com') }
      let!(:some_other_user) { create(:user) }

      it 'returns the user' do
        expect(User.find_for_facebook_oauth(access_token)).to eq existing_user
      end
    end

    context 'when user is found via provider&social_url' do
      let!(:existing_user) do
        create(:user, provider: 'facebook',
          social_url: 'https://facebook.com/1703636318')
      end
      let!(:some_other_user) { create(:user) }

      it 'returns the user' do
        expect(User.find_for_facebook_oauth(access_token)).to eq existing_user
      end
    end
  end
end
