defmodule ExMeal.Meals.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [
             :id,
             :calories,
             :date,
             :description
           ]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "meals" do
    field :calories, :string
    field :date, :naive_datetime
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, [:description, :date, :calories])
    |> validate_required([:description, :date, :calories])
  end
end
