defmodule ExMealWeb.UserControllerTest do
  use ExMealWeb.ConnCase, async: true

  import ExMeal.Factory

  alias ExMeal.Users.User

  describe "create/2" do
    test "When all params are valid, inserts a user into the database.", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User successfully created!",
               "user" => %{
                 "cpf" => "001.324.030-23",
                 "email" => "maiqui@email.com",
                 "id" => _idp,
                 "name" => "Maiqui Pirolli Tomé"
               }
             } = response
    end

    test "When any param is blank, returns an error.", %{conn: conn} do
      params = %{
        cpf: "",
        email: "",
        name: ""
      }

      response =
        conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "cpf" => ["can't be blank"],
                 "email" => ["can't be blank"],
                 "name" => ["can't be blank"]
               }
             } = response
    end
  end

  describe "show/2" do
    test "When there is a user with the given ID, returns the user", %{conn: conn} do
      %User{id: id} = insert(:user)

      response =
        conn
        |> get(Routes.user_path(conn, :show, id))
        |> json_response(:ok)

      expected_response = %{
        "user" => %{
          "cpf" => "001.324.030-23",
          "email" => "maiqui@email.com",
          "id" => "a0694167-d1c7-45a7-a1db-7f1e60e1275d",
          "name" => "Maiqui Pirolli Tomé"
        }
      }

      assert response == expected_response
    end

    test "When there is no a user with the given ID, returns an error", %{conn: conn} do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      response =
        conn
        |> get(Routes.user_path(conn, :show, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found!"}

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "When there is a user with the given ID, deletes the user.", %{conn: conn} do
      %User{id: id} = insert(:user)

      response =
        conn
        |> delete(Routes.user_path(conn, :delete, id))
        |> response(:no_content)

      expected_response = ""

      assert response == expected_response
    end

    test "When there is no a user with the given ID, returns an error.", %{conn: conn} do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      response =
        conn
        |> delete(Routes.user_path(conn, :delete, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found!"}

      assert response == expected_response
    end
  end
end
