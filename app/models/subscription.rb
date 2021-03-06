class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validate :check_user

  validates :event, presence: true

  validates :user_name, presence: true, unless: :user_present?
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: :user_present?
  validate :check_email, unless: :user_present?

  validates :user, uniqueness: { scope: :event_id }, if: :user_present?
  validates :user_email, uniqueness: { scope: :event_id }, unless: :user_present?

  after_commit :update_info, on: :create

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def user_present?
    user.present?
  end

  private

  def check_user
    errors.add(:event, I18n.t('controllers.subscription.error')) if event.user == user
  end

  def check_email
    if User.find_by(email: user_email).present?
      errors.add(:event, I18n.t('controllers.subscription.error'))
    end
  end

  def update_info
    update(user_name: user_name, user_email: user_email)
  end
end
