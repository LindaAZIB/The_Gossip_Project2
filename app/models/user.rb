require 'bcrypt'

class User < ApplicationRecord
	belongs_to :city, optional: true
  has_many :gossips
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"
  has_many :comments
  has_many :likes, dependent: :destroy

  has_secure_password

 
  validates :pseudo, presence: true, uniqueness: true
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 3 }

  include BCrypt

  def password_authentification(mdp_confirmation, user)
    
  end

  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update(remember_digest: remember_digest)
  end

end