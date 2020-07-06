class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # devise :invitable, :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable, require_password_on_accepting: false

  has_many :invitations
  has_many :events, through: :invitations

  attr_accessor :invited_to

  def name
    super || email
  end

  def set_status_for(event, status)
    invitation = Invitation.find_by(event: event, user: self)
    invitation.status = status
    invitation.save #update
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end
end
