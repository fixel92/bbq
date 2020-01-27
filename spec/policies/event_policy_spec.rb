require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:user) { User.new }
  let(:user2) { User.new }
  let(:event_1) { Event.create(user: user, title: 'Шашлыки', address: 'Минск', datetime: '2020-01-31 15:31:00') }

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
