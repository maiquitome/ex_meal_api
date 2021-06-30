defmodule ExMeal.Factory do
  use ExMachina.Ecto, repo: ExMeal.Repo

  alias ExMeal.Meals.Meal

  def meal_params_factory do
    %{
      calories: "100 kcal",
      date: "2016-04-16 13:30:15",
      description: "1 Ovo"
    }
  end

  def meal_factory do
    %Meal{
      calories: "100 kcal",
      date: "2016-04-16T13:30:15",
      description: "1 Ovo",
      id: "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8"
    }
  end
end
