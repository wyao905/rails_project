class User < ApplicationRecord
    has_many :donations
    has_many :actions
    has_many :exhibits, through: :donations
    has_many :animals, through: :actions
end
