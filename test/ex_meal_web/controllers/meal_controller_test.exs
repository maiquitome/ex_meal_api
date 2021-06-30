defmodule ExMealWeb.MealControllerTest do
  use ExMealWeb.ConnCase, async: true

  import ExMeal.Factory

  alias ExMeal.Meals.Meal

  describe "create/2" do
    test "when all params are valid, inserts a meal into the database.", %{conn: conn} do
      params = build(:meal_params)

      response =
        conn
        |> post(Routes.meal_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "meal" => %{
                 "calories" => "100 kcal",
                 "date" => "2016-04-16T13:30:15",
                 "description" => "1 Ovo",
                 "id" => _id
               },
               "message" => "Meal successfully created!"
             } = response
    end

    test "when some param is invalid, returns an error", %{conn: conn} do
      params = %{
        calories: "",
        date: "",
        description: ""
      }

      response =
        conn
        |> post(Routes.meal_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "calories" => ["can't be blank"],
                 "date" => ["can't be blank"],
                 "description" => ["can't be blank"]
               }
             } = response
    end
  end

  describe "show/2" do
    test "when there is an user with the given id, returns the meal from the database.", %{
      conn: conn
    } do
      %Meal{id: id} = insert(:meal)

      response =
        conn
        |> get(Routes.meal_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => "100 kcal",
                 "date" => "2016-04-16T13:30:15",
                 "description" => "1 Ovo",
                 "id" => "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8"
               }
             } = response
    end

    test "when there is no an user with the given id, returns an error.", %{conn: conn} do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      response =
        conn
        |> get(Routes.meal_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"message" => "Meal not found!"} = response
    end
  end
end
