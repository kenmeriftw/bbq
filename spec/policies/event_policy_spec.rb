require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do

  subject { described_class }

  let(:user) { FactoryBot.create(:user) }

  let(:event_pincodeless) { FactoryBot.create(:event, user: user) }
  let(:event_pincoded) { FactoryBot.create(:event, user: user, pincode: '1234') }

  let(:cookies) { { "events_#{event_pincoded.id}_pincode" => '1234' } }

  context 'user is event owner' do
    let(:event_owner) { AuthorizationContext.new(user, {}) }

    permissions :destroy?, :edit?, :update?  do
      it { is_expected.to permit(event_owner, event_pincodeless) }
    end

    permissions :show? do
      it { is_expected.to permit(event_owner, event_pincodeless) }
      it { is_expected.to permit(event_owner, event_pincoded) }
    end
  end

  context 'user is not event owner' do
    let(:usual_user) { FactoryBot.create(:user) }
    let(:usual_user_pincodeless) { AuthorizationContext.new(usual_user, {}) }
    let(:usual_user_pincoded) { AuthorizationContext.new(usual_user, cookies) }

    permissions :destroy?, :edit?, :update?  do
      it { is_expected.not_to permit(usual_user_pincodeless, event_pincodeless) }
    end

    permissions :show? do
      it { is_expected.to permit(usual_user_pincodeless, event_pincodeless) }
      it { is_expected.not_to permit(usual_user_pincodeless, event_pincoded) }
      it { is_expected.to permit(usual_user_pincoded, event_pincoded) }
    end
  end

  context 'anon' do
    let (:anon_pincoded) { AuthorizationContext.new(nil, cookies) }
    permissions :destroy?, :edit?, :update?  do
      it { is_expected.not_to permit(anon_pincoded, event_pincoded) }
    end

    permissions :show? do
      it { is_expected.to permit(anon_pincoded, event_pincoded) }
    end
  end
end
