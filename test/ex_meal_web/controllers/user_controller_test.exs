defmodule ExMealWeb.UserControllerTest do
  use ExMealWeb.ConnCase, async: true

  import ExMeal.Factory

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
end
