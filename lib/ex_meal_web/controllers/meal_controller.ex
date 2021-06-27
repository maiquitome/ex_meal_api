defmodule ExMealWeb.MealController do
  use ExMealWeb, :controller

  alias ExMeal.Meals.{Create, Meal}

  action_fallback ExMealWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end
end
