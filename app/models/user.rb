class User < ApplicationRecord
  #it belongs to teams with many to many
  before_validation :downcase_username
  validates :username, presence: true, uniqueness: true
  has_and_belongs_to_many :teams
  belongs_to :user_status
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def downcase_username
    self.username = username.downcase if username.present?
  end
  
end
