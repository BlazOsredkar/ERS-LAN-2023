# app/models/game.rb
class Game < ApplicationRecord
  has_many :teams

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "link", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["teams"]
  end
end
