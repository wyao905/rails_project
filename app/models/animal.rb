class Animal < ApplicationRecord
    belongs_to :exhibit
    has_many :actions
    has_many :users, through: :actions
end
