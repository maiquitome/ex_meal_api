defmodule ExMeal do
  @moduledoc """
  ExMeal keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias ExMeal.Error
  alias ExMeal.Meals.Meal
  alias ExMeal.Meals.Create, as: CreateMeal
  alias ExMeal.Meals.Get, as: GetMeal

  @typedoc """
  Meal params.
  """
  @type meal_params :: %{
          calories: String.t(),
          date: Calendar.naive_datetime(),
          description: String.t()
        }

  @doc """
  Inserts a meal into the database.

  ## Examples

        iex> params = %{calories: "100 kcal", date: "2016-04-16 13:30:15", description: "1 Ovo"}

        iex> ExMeal.create_meal(params)
        {:ok, %Meal{}}

        iex> ExMeal.create_meal(%{})
        %ExMeal.Error{result: %Ecto.Changeset{}, status: :bad_request}

  """
  @spec create_meal(meal_params()) ::
          {:ok, Meal.t()}
          | {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
  defdelegate create_meal(meal_params),
    to: CreateMeal,
    as: :call

  @doc """
  Gets a meal from the database.

  ## Examples

      iex> ExMeal.get_meal_by_id("aba9fe82-77bd-4c9c-b28f-a09085d2a24b")
      {:ok, %ExMeal.Meals.Meal{}}

      iex> ExMeal.get_meal_by_id("aba9fe82-77bd-4c9c-b28f-a09085d2a24a")
      {:error, %Error{result: "Meal not found.", status: :not_found}}

  """
  @spec get_meal_by_id(Ecto.UUID) ::
          {:ok, %Meal{}} | {:error, %Error{result: String.t(), status: :not_found}}
  defdelegate get_meal_by_id(meal_id),
    to: GetMeal,
    as: :by_id
end
