defmodule ExMeal.Meals.Delete do
  @moduledoc """
  Delete a meal from the database.
  """

  alias ExMeal.Meals.Meal
  alias ExMeal.{Error, Repo}

  @doc """
  Delete a meal from the database.

  ## Examples

      iex> ExMeal.Meals.Delete.call("867a7df1-4461-4f87-8f33-f0c299ac56df")
      {:ok, %ExMeal.Meals.Meal{}}

      iex> ExMeal.Meals.Delete.call("867a7df1-4461-4f87-8f33-f0c299ac56da")
      {:error, %ExMeal.Error{result: "Meal not found!", status: :not_found}}

  """
  @spec call(Ecto.UUID) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
          | {:ok, Meal.t()}
  def call(meal_id) do
    with {:ok, %Meal{} = meal} <- ExMeal.get_meal_by_id(meal_id) do
      case Repo.delete(meal) do
        {:ok, _struct} = result -> result
        {:error, changeset} -> {:error, Error.build(changeset, :bad_request)}
      end
    end
  end
end
