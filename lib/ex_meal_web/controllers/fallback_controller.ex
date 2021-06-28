defmodule ExMealWeb.FallbackController do
  use ExMealWeb, :controller

  alias ExMealWeb.ErrorView

  def call(conn, {:error, error = error}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", error: error)
  end
end
