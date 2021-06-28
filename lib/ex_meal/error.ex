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
end
