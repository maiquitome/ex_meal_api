defmodule ExMealWeb.MealView do
  use ExMealWeb, :view

  alias ExMeal.Meals.Meal

  def render("meal.json", %{meal: %Meal{} = meal}) do
    %{
      meal: meal
    }
  end
end
