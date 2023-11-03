class Team < ApplicationRecord
    #has many to many users
    has_and_belongs_to_many :users
end
