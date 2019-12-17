class Animal < ApplicationRecord
    belongs_to :exhibit
    has_many :actions
    has_many :users, through: :actions

    def mood
        case (self.hunger + self.health)
        when 3..4
            "#{self.name} seems to be enjoying life."
        when 1..2
            "#{self.name} looks quite pleased."
        when 0
            "#{self.name} seems unperturbed."
        when -2..-1
            "#{self.name} seems slightly grumpy."
        else
            "#{self.name} does not look happy at all."
        end
    end

    def how_hungry
        case self.hunger
        when 5
            "#{self.name} looks like it just had a large meal."
        when 4
            "#{self.name} does not seem hungry."
        when 3
            "#{self.name} looks well off."
        when 2
            "#{self.name} seems slightly peckish."
        else
            "#{self.name} looks like it's starving."
        end
    end

    def how_healthy
        # if self.health
        # when 
        #     "#{self.name} looks as fit as ever."
        # else
        #     "#{self.name} looks like it's sick."
        # end
    end
end
