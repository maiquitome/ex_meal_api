defmodule ExMeal.Repo do
  use Ecto.Repo,
    otp_app: :ex_meal,
    adapter: Ecto.Adapters.Postgres
end
