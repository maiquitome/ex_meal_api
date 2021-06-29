defmodule ExMealWeb.MealController do
  use ExMealWeb, :controller

  alias ExMeal.Meals.Meal

  action_fallback ExMealWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- ExMeal.create_meal(params) do
      conn
      |> put_status(:created)
  def show(conn, %{"id" => id}) do
    with {:ok, %Meal{} = meal} <- ExMeal.get_meal_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end
end
