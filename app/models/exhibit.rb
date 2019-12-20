class Exhibit < ApplicationRecord
    has_many :animals
    has_many :donations
    has_many :users, through: :donations

    def animals_attributes=(animal_attributes)
        animal_attributes.values.each do |animal_attribute|
            animal = Animal.find_or_create_by(animal_attribute)
            self.animals << animal
        end
    end
end
