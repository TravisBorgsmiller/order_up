require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when i visit a chef show page' do
    it 'shows chef name and link to ingredients index with unique list' do
      chef = Chef.create(name: 'Ramsey')
      chef2 = Chef.create(name: 'Gordon')
      dish = Dish.create(name: 'Pie', description: 'Sweet and savory')
      dish2 = Dish.create(name: 'Pizza', description: 'Charred to perfection')
      dish3 = Dish.create(name: 'Burrito', description: 'Avacodo Lovin')
      chef2.dishes << dish3
      chef.dishes << [dish, dish2]
      ingredient1 = Ingredient.create(name: 'crust', calories: 100)
      ingredient2 = Ingredient.create(name: 'cinnamon', calories: 50)
      ingredient3 = Ingredient.create(name: 'chicken', calories: 60)
      ingredient4 = Ingredient.create(name: 'sauce', calories: 80)

      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient1.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient2.id)
      DishIngredient.create(dish_id: dish2.id, ingredient_id: ingredient1.id)
      DishIngredient.create(dish_id: dish2.id, ingredient_id: ingredient4.id)
      DishIngredient.create(dish_id: dish3.id, ingredient_id: ingredient3.id)

      visit "/chefs/#{chef.id}"
      expect(current_path).to eq("/chefs/#{chef.id}")
      expect(page).to have_content(chef.name)
      expect(page).to_not have_content(chef2.name)

      click_link('Ingredients Used')
      expect(current_path).to eq("/chefs/#{chef.id}/ingredients")
      expect(page).to have_content(ingredient1.name)
      expect(page).to have_content(ingredient2.name)
      expect(page).to have_content(ingredient4.name)
      expect(page).to_not have_content(ingredient3.name)
    end
  end
end 
