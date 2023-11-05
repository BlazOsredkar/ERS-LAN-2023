class Team < ApplicationRecord
    #has many to many users
    has_and_belongs_to_many :users
    belongs_to :user
    has_and_belongs_to_many :games, join_table: :team_games


    def self.ransackable_attributes(auth_object = nil)
        ["code", "created_at", "id", "name", "updated_at", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["user", "users"]
    end
end
