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

end
