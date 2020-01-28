require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:event_1) { FactoryBot.create(:event, user: user) }

  subject { EventPolicy }

  context 'anonym user' do
    permissions :create? do
      it { is_expected.not_to permit(nil, Event) }
    end

    permissions :update?, :destroy?, :edit? do
      it { is_expected.not_to permit(nil, event_1) }
    end
  end

  context 'other user' do
    permissions :create? do
      it { is_expected.to permit(user2, Event) }

    end

    permissions :update?, :destroy?, :edit? do
      it { is_expected.not_to permit(user2, event_1) }
    end
  end

  context 'user owner event' do
    permissions :create? do
      it { is_expected.to permit(user, Event) }
    end

    permissions :update?, :destroy?, :edit? do
      it { is_expected.to permit(user, event_1) }
    end
  end
end
