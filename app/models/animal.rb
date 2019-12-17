class Animal < ApplicationRecord
    belongs_to :exhibit
    has_many :actions
    has_many :users, through: :actions

    def mood
        score = self.hunger
        if self.sick
            score -= 3
        else
            score += 1
        end

        if score < -3
            score = -3
        elsif score > 3
            score = 3
        end
        
        case score
        when 3
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
        when 2
            "#{self.name} looks like it just had a large meal."
        when 1
            "#{self.name} does not seem hungry."
        when 0
            "#{self.name} looks well off."
        when -1
            "#{self.name} seems slightly peckish."
        else
            "#{self.name} looks like it's starving."
        end
    end
end
