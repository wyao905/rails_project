class Animal < ApplicationRecord
    belongs_to :exhibit
    has_many :actions
    has_many :users, through: :actions

    validates :name, :species, presence: true

    def mood
        score = self.hunger.to_i
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
        when "2"
            "#{self.name} looks like it just had a large meal."
        when "1"
            "#{self.name} does not seem hungry."
        when "0"
            "#{self.name} looks well off."
        when "-1"
            "#{self.name} seems slightly peckish."
        else
            "#{self.name} looks like it's starving."
        end
    end

    def health
        if !self.sick
            num = rand(1..10)
            if num <= 2
                self.sick = true
            else
                false
            end
        else
            false
        end
    end

    def self.species
        list_species = []
        self.all.each do |a|
            list_species << a.species if !list_species.include?(a.species)
        end
        list_species
    end
end
