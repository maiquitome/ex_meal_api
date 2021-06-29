defmodule ExMeal.Meals.Get do
  @moduledoc """
  Gets a meal from the database.
  """
  alias ExMeal.Repo
  alias ExMeal.Meals.Meal
  alias ExMeal.Error

  @doc """
  Gets a meal from the database.

  ## Examples

      iex> ExMeal.Meals.Get.by_id("aba9fe82-77bd-4c9c-b28f-a09085d2a24b")
      {:ok, %ExMeal.Meals.Meal{}}

      iex> ExMeal.Meals.Get.by_id("aba9fe82-77bd-4c9c-b28f-a09085d2a24a")
      {:error, %Error{result: "Meal not found!", status: :not_found}}

  """
  @spec by_id(Ecto.UUID) ::
          {:ok, %Meal{}} | {:error, %Error{result: String.t(), status: :not_found}}
  def by_id(meal_id) do
    case Repo.get(Meal, meal_id) do
      %Meal{} = meal -> {:ok, meal}
      nil -> {:error, Error.build_meal_not_found_error()}
    end
  end
end
