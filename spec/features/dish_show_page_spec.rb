require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when i visit a dishes show page' do
    it 'shows dish and its information' do
      chef = Chef.create(name: 'Ramsey')

      dish = Dish.create(name: 'Pie', description: 'Sweet and savory')
      dish2 = Dish.create(name: 'Pizza', description: 'Charred to perfection')
      chef.dishes << dish
      ingredient1 = Ingredient.create(name: 'crust', calories: 100)
      ingredient2 = Ingredient.create(name: 'cinnamon', calories: 50)

      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient1.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient2.id)

      visit "/dishes/#{dish.id}"
      expect(current_path).to eq("/dishes/#{dish.id}")

      expect(page).to have_content(dish.name)
      expect(page).to have_content(ingredient1.name)
      expect(page).to have_content(ingredient2.name)
      expect(page).to_not have_content(dish2.name)
      expect(page).to have_content(chef.name)
    end
    it 'shows calorie count for that dish' do
      chef = Chef.create(name: 'Ramsey')

      dish = Dish.create(name: 'Pie', description: 'Sweet and savory')
      dish2 = Dish.create(name: 'Pizza', description: 'Charred to perfection')
      chef.dishes << dish
      ingredient1 = Ingredient.create(name: 'crust', calories: 100)
      ingredient2 = Ingredient.create(name: 'cinnamon', calories: 50)

      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient1.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient2.id)
      visit "/dishes/#{dish.id}"
      expect(current_path).to eq("/dishes/#{dish.id}")
      expect(page).to have_content(dish.name)
      expect(page).to have_content('Calories: 150')
    end
  end
end
