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

  def show(conn, %{"id" => id}) do
    with {:ok, %Meal{} = meal} <- ExMeal.get_meal_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Meal{}} <- ExMeal.delete_meal(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, %Meal{} = meal} <- ExMeal.update_meal(id, params) do
      conn
      |> put_status(:ok)
      |> render("update.json", meal: meal)
    end
  end
end
