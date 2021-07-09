defmodule ExMealWeb.UserViewTest do
  use ExMealWeb.ConnCase, async: true

  import Phoenix.View
  import ExMeal.Factory

  alias ExMeal.Users.User
  alias ExMealWeb.UserView

  test "renders create.json" do
    user = build(:user)

    response = render(UserView, "create.json", user: user)

    assert %{
             message: "User successfully created!",
             user: %User{
               cpf: "001.324.030-23",
               email: "maiqui@email.com",
               id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d",
               inserted_at: nil,
               name: "Maiqui Pirolli Tomé",
               updated_at: nil
             }
           } = response
  end

  test "renders users.json" do
    %User{} = user = build(:user)

    response = render(UserView, "user.json", user: user)

    assert %{
             user: %User{
               cpf: "001.324.030-23",
               email: "maiqui@email.com",
               id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d",
               inserted_at: nil,
               name: "Maiqui Pirolli Tomé",
               updated_at: nil
             }
           } = response
  end

  test "renders update.json" do
    %User{} = user = build(:user)

    response = render(UserView, "update.json", user: user)

    assert %{
             message: "User successfully updated!",
             user: %User{
               cpf: "001.324.030-23",
               email: "maiqui@email.com",
               id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d",
               inserted_at: nil,
               name: "Maiqui Pirolli Tomé",
               updated_at: nil
             }
           } = response
  end
end
