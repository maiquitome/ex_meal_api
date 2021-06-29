defmodule ExMealWeb.FallbackController do
  use ExMealWeb, :controller

  alias ExMeal.Error
  alias ExMealWeb.ErrorView

  def call(conn, {:error, %Error{result: changeset_or_message, status: status}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: changeset_or_message)
  end
end
