class User < ApplicationRecord
  #it belongs to teams with many to many
  before_validation :downcase_username
  validates :username, presence: true, uniqueness: true
  has_and_belongs_to_many :teams
  belongs_to :user_status

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  def admin?
    self.isadmin == true
  end

  private

  def downcase_username
    self.username = username.downcase if username.present?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["confirmation_sent_at", "confirmation_token", "confirmed_at", "created_at", "current_sign_in_at", "current_sign_in_ip", "email", "encrypted_password", "has_equipment", "id", "isadmin", "last_sign_in_at", "last_sign_in_ip", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "sign_in_count", "surname", "unconfirmed_email", "updated_at", "user_status_id", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["teams", "user_status"]
  end


end
