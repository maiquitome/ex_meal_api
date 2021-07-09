defmodule ExMeal.Users.Update do
  @moduledoc """
  Updates a user in the database.
  """

  alias ExMeal.{Error, Repo}
  alias ExMeal.Users.User

  @type params :: %{
          cpf: String.t(),
          email: String.t(),
          name: String.t()
        }

  @doc """
  Updates a user in the database.

  ## Examples

        iex> id = "f5be7320-50e6-4ee8-8d0c-db79d3668393"

        iex> params = %{
          cpf: "001.324.030-23",
          email: "maiqui@email.com",
          name: "Mike Pirolli Tomé"
        }

        iex> ExMeal.Users.Update.call id, params
        {:ok, %ExMeal.Users.User{}}

        iex> ExMeal.Users.Update.call "f5be7320-50e6-4ee8-8d0c-db79d3668391", params
        {:error, %ExMeal.Error{result: "User not found!", status: :not_found}}

  """
  @spec call(Ecto.UUID, params()) ::
          {:error,
           %Error{
             result: String.t() | Ecto.Changeset.t(),
             status: :not_found | :bad_request
           }}
          | {:ok, User.t()}
  def call(id, %{} = params) do
    with {:ok, %User{} = user} <- ExMeal.get_user_by_id(id) do
      changeset = User.changeset(user, params)

      case Repo.update(changeset) do
        {:ok, _schema} = user -> user
        {:error, changeset} -> {:error, Error.build(changeset, :bad_request)}
      end
    end
  end
end
