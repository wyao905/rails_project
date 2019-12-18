class User < ApplicationRecord
    has_secure_password
    
    has_many :donations
    has_many :actions
    has_many :exhibits, through: :donations
    has_many :animals, through: :actions

    def donation_status
        if self.donations.size == 0
            "You have made no donations."
        else
            sum = 0
            self.donations.each{|donation| sum += donation.amount}
            if sum >= 100000
                "Platinum"      # user can claim/create an exhibit and appoint zookeepers
            elsif sum >= 10000
                "Gold"          # user can adopt up to 5 animals
            elsif sum >= 1000
                "Silver"        # user can adopt an animal (name, feed, see list of actions for animal)
            else
                "Bronze"        # everyone starts off at bronze
            end
        end
    end
end
