class Exhibit < ApplicationRecord
    has_many :animals
    has_many :donations
    has_many :users, through: :donations

    validates :name, presence: true
    validates :funds, numericality: { only_integer: true }

    def animals_attributes=(animal_attributes)
        animal_attributes.values.each do |animal_attribute|
            animal = Animal.create(animal_attribute)
            animal.update(hunger: rand(-2..2))
            animal.update(sick: animal.health)
            self.animals << animal
        end
    end
end
