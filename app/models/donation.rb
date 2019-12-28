class Donation < ApplicationRecord
    belongs_to :user
    belongs_to :exhibit

    validates :amount, numericality: { only_integer: true }
end
