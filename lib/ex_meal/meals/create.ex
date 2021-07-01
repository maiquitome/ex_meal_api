defmodule ExMeal.Meals.Create do
  @moduledoc """
  Inserts a meal into the database.
  """
  alias ExMeal.{Error, Repo}
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

        iex> params = %{calories: "100 kcal", date: "2016-04-16 13:30:15", description: "1 Ovo"}

        iex> ExMeal.Meals.Create.call(params)
        {:ok, %Meal{}}

        iex> ExMeal.Meals.Create.call(%{})
        %ExMeal.Error{result: %Ecto.Changeset{}, status: :bad_request}

  """
  @spec call(params()) ::
          {:ok, Meal.t()}
          | {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Meal{}} = result), do: result

  defp handle_insert({:error, %Ecto.Changeset{} = changeset}) do
    {:error, Error.build(changeset, :bad_request)}
  end
end
