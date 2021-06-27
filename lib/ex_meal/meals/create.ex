defmodule ExMeal.Meals.Create do
  @moduledoc """
  Inserts a meal into the database.
  """
  alias ExMeal.Repo
  alias ExMeal.Meals.Meal

  @typedoc """
  Meal params.
  """
  @type params :: %{
          calories: String.t(),
          date: Calendar.naive_datetime(),
          description: String.t()
        }

  @doc """
  Inserts a meal into the database.

  ## Examples

        iex> params = %{calories: "100 kcal", date: ~N[2016-04-16 13:30:15], description: "1 Ovo"}

        iex> ExMeal.Meals.Create.call(params)
        {:ok, %Meal{}}

        iex> ExMeal.Meals.Create.call(%{})
        {:error, %Ecto.Changeset{}}

  """
  @spec call(params()) :: {:ok, Meal.t()} | {:error, Ecto.Changeset.t()}
  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
  end
end
