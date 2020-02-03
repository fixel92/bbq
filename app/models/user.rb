class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: { maximum: 35 }

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
  def self.find_for_facebook_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    url = "https://facebook.com/#{id}"
    name = access_token.extra.raw_info.name

    where(url: url, provider: provider).first_or_create! do |user|
      user.name = name
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
  end

end
