class User < ApplicationRecord
  #it belongs to teams with many to many
  has_and_belongs_to_many :teams
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
end
