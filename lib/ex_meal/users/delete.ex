defmodule ExMeal.Users.Delete do
  @moduledoc """
  Delete a user from the database.
  """
  alias ExMeal.{Error, Repo}
  alias ExMeal.Users.User

  @doc """
  Delete a user from the database.

  ## Examples

      iex> ExMeal.Users.Delete.call("29dbc706-06fe-42d8-860a-390ffb7652a4")
      {:ok, %ExMeal.Users.User{}}

      iex> ExMeal.Users.Delete.call("29dbc706-06fe-42d8-860a-390ffb7652a4")
      {:error, %ExMeal.Error{result: "User not found!", status: :not_found}}

  """
  @spec call(Ecto.UUID) ::
          {:error,
           %Error{
             result: String.t() | Ecto.Changeset.t(),
             status: :not_found | :bad_request
           }}
          | {:ok, User.t()}
  def call(id) do
    with {:ok, %User{} = user} <- ExMeal.get_user_by_id(id) do
      case Repo.delete(user) do
        {:ok, _schema} = user -> user
        {:error, changeset} -> {:error, Error.build(changeset, :bad_request)}
      end
    end
  end
end
