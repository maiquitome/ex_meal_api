defmodule ExMeal.Factory do
  use ExMachina.Ecto, repo: ExMeal.Repo

  def meal_params_factory do
    %{
      calories: "100 kcal",
      date: "2016-04-16 13:30:15",
      description: "1 Ovo"
    }
  end
end
