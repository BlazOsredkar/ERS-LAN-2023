class Team < ApplicationRecord
    #has many to many users
    has_and_belongs_to_many :users
    belongs_to :user


    def self.ransackable_attributes(auth_object = nil)
        ["code", "created_at", "id", "name", "updated_at", "user_id"]
    end
end
