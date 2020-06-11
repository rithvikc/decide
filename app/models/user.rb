class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :invitable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :invitations
  has_many :events, through: :invitations
end
