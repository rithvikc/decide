class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, require_password_on_accepting: false
  has_many :invitations
  has_many :events, through: :invitations

  attr_accessor :invited_to

  def name
    super || email
  end
end
