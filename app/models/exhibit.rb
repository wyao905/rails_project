class Exhibit < ApplicationRecord
    has_many :animals
    has_many :donations
    has_many :users, through: :donations
end
