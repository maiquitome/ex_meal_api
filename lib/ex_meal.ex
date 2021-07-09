defmodule ExMeal do
  @moduledoc """
  ExMeal keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias ExMeal.Error

  alias ExMeal.Meals.Create, as: CreateMeal
  alias ExMeal.Meals.Delete, as: DeleteMeal
  alias ExMeal.Meals.Get, as: GetMeal
  alias ExMeal.Meals.Meal
  alias ExMeal.Meals.Update, as: UpdateMeal

  alias ExMeal.Users.Create, as: CreateUser
  alias ExMeal.Users.Get, as: GetUser
  alias ExMeal.Users.Delete, as: DeleteUser
  alias ExMeal.Users.Update, as: UpdateUser

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

  @doc """
  Delete a meal from the database.

  ## Examples

      iex> ExMeal.delete_meal("867a7df1-4461-4f87-8f33-f0c299ac56df")
      {:ok, %ExMeal.Meals.Meal{}}

      iex> ExMeal.delete_meal("867a7df1-4461-4f87-8f33-f0c299ac56da")
      {:error, %ExMeal.Error{result: "Meal not found!", status: :not_found}}

  """
  @spec delete_meal(Ecto.UUID) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
          | {:ok, Meal.t()}
  defdelegate delete_meal(meal_id),
    to: DeleteMeal,
    as: :call

  @doc """
  Updates a meal in the database.

  ## Examples

      iex> meal_id = "8aa2e580-7726-49ee-8f83-3c86d79d4a08"

      iex> params = %{calories: "200 kcal", date: "2016-05-16 13:30:15", description: "2 Ovos"}

      iex> ExMeal.update_meal(meal_id, params)
      {:ok, %ExMeal.Meals.Meal{}}

      iex> ExMeal.update_meal("8aa2e580-7726-49ee-8f83-3c86d79d4a00", params)
      {:error, %ExMeal.Error{result: "Meal not found!", status: :not_found}}

      iex> ExMeal.update_meal(meal_id, %{calories: "", date: "", description: ""})
      {:error, %Error{result: %Ecto.Changeset{}, status: :bad_request}}

  """
  @spec update_meal(Ecto.UUID, meal_params()) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
          | {:ok, Meal.t()}
  defdelegate update_meal(meal_id, meal_params),
    to: UpdateMeal,
    as: :call

  ################
  #
  # USERS
  #
  ################

  @typedoc """
  User params.
  """
  @type user_params :: %{
          cpf: String.t(),
          email: String.t(),
          name: String.t()
        }

  @doc """
  Inserts a user into the database.

  ## Examples

      iex> params = %{
        cpf: "001.324.030-23",
        email: "maiqui@email.com",
        name: "Maiqui Pirolli Tomé"
      }

      iex> ExMeal.create_user(params)
      {:ok, %ExMeal.Users.User{}}

      iex> ExMeal.create_user(%{})
      {:error, %ExMeal.Error{result: %Ecto.Changeset{}, status: :bad_request}}

  """
  @spec create_user(user_params()) ::
          {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
          | {:ok, User.t()}
  defdelegate create_user(params),
    to: CreateUser,
    as: :call

  @doc """
  Returns a user from the database.

  ## Examples

      iex> ExMeal.get_user_by_id "e79b23ae-5813-4ec3-9976-99493905f5e8"
      {:ok, %ExMeal.Users.User{}}

      iex> ExMeal.get_user_by_id "e79b23ae-5813-4ec3-9976-99493905f5e9"
      {:error, %ExMeal.Error{result: "User not found!", status: :not_found}}

  """
  @spec get_user_by_id(Ecto.UUID) ::
          {:ok, Usert.t()}
          | {:error, %Error{result: String.t(), status: :not_found}}
  defdelegate get_user_by_id(id),
    to: GetUser,
    as: :by_id

  @doc """
  Delete a user from the database.

  ## Examples

      iex> ExMeal.delete_user("29dbc706-06fe-42d8-860a-390ffb7652a4")
      {:ok, %ExMeal.Users.User{}}

      iex> ExMeal.delete_user("29dbc706-06fe-42d8-860a-390ffb7652a4")
      {:error, %ExMeal.Error{result: "User not found!", status: :not_found}}

  """
  @spec delete_user(Ecto.UUID) ::
          {:error,
           %Error{
             result: String.t() | Ecto.Changeset.t(),
             status: :not_found | :bad_request
           }}
          | {:ok, User.t()}
  defdelegate delete_user(id),
    to: DeleteUser,
    as: :call

  @doc """
  Updates a user in the database.

  ## Examples

        iex> id = "f5be7320-50e6-4ee8-8d0c-db79d3668393"

        iex> params = %{
          cpf: "001.324.030-23",
          email: "maiqui@email.com",
          name: "Mike Pirolli Tomé"
        }

        iex> ExMeal.update_user id, params
        {:ok, %ExMeal.Users.User{}}

        iex> ExMeal.update_user "f5be7320-50e6-4ee8-8d0c-db79d3668391", params
        {:error, %ExMeal.Error{result: "User not found!", status: :not_found}}

  """
  @spec update_user(Ecto.UUID, user_params()) ::
          {:error,
           %Error{
             result: String.t() | Ecto.Changeset.t(),
             status: :not_found | :bad_request
           }}
          | {:ok, User.t()}
  defdelegate update_user(id, params),
    to: UpdateUser,
    as: :call
end
