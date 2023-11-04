# app/models/user_status.rb
class UserStatus < ApplicationRecord
  # Your UserStatus model code
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
