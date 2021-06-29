defmodule ExMealWeb.MealController do
  use ExMealWeb, :controller

  alias ExMeal.Meals.Meal

  action_fallback ExMealWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- ExMeal.create_meal(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end
end
