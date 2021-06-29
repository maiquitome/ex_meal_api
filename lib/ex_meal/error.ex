defmodule ExMeal.Error do
  @moduledoc """
  Creates error messages.
  """

  @enforce_keys [:result, :status]

  defstruct [:result, :status]

  @spec build(atom, String.t() | Ecto.Changeset.t()) :: %__MODULE__{
          result: String.t() | Ecto.Changeset.t(),
          status: atom
        }
  @doc """
  Build an error struct.
  """
  def build(status, result) do
    %__MODULE__{
      result: result,
      status: status
    }
  end

  @spec build_meal_not_found_error :: %__MODULE__{result: String.t(), status: :not_found}
  def build_meal_not_found_error, do: build(:not_found, "Meal not found!")
end
