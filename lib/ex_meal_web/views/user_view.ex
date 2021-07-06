defmodule ExMealWeb.UserView do
  use ExMealWeb, :view

  alias ExMeal.Users.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User successfully created!",
      user: user
    }
  end
end
