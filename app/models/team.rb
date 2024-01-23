class Team < ApplicationRecord
    #has many to many users
    has_and_belongs_to_many :users
    belongs_to :user
    belongs_to :game

    has_one_attached :avatar

    validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }


    def self.ransackable_attributes(auth_object = nil)
      ["code", "created_at", "game_id", "id", "is_verified", "name", "updated_at", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
      ["game", "user", "users"]
    end



end
