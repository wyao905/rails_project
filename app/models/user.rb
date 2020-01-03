class User < ApplicationRecord
    has_secure_password
    
    has_many :donations
    has_many :actions
    has_many :exhibits, through: :donations
    has_many :animals, through: :actions
    
    validates :username, :password, :balance, presence: true
    validates :username, uniqueness: true
    validates :balance, numericality: { only_integer: true }

    def donation_status
        if self.donations.size == 0
            "You have made no donations."
        else
            sum = 0
            self.donations.each{|donation| sum += donation.amount}
            if sum >= 100000
                "Platinum"
            elsif sum >= 10000
                "Gold"
            elsif sum >= 1000
                "Silver"
            else
                "Bronze"
            end
        end
    end
end
