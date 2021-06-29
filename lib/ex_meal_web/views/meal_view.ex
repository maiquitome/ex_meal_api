defmodule ExMealWeb.MealView do
  use ExMealWeb, :view

  alias ExMeal.Meals.Meal

  def render("create.json", %{meal: %Meal{} = meal}) do
    %{
      message: "Meal successfully created!",
      meal: meal
    }
  end

  def render("meal.json", %{meal: %Meal{} = meal}) do
    %{
      meal: meal
    }
  end
end
