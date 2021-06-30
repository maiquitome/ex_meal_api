defmodule ExMealTest do
  use ExMeal.DataCase, async: true

  import ExMeal.Factory

  alias ExMeal.Meals.Meal
  alias ExMeal.Error

  describe "create_meal/1" do
    test "when all params are valid, inserts a meal into the database." do
      params = build(:meal_params)

      response = ExMeal.create_meal(params)

      assert {:ok,
              %Meal{
                calories: "100 kcal",
                date: ~N[2016-04-16 13:30:15],
                description: "1 Ovo",
                id: _id,
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "when some param is invalid, returns an error" do
      params = %{
        calories: "",
        date: "",
        description: ""
      }

      response = ExMeal.create_meal(params)

      assert {:error,
              %Error{
                result: %Ecto.Changeset{
                  action: :insert,
                  changes: %{},
                  errors: [
                    description: {"can't be blank", [validation: :required]},
                    date: {"can't be blank", [validation: :required]},
                    calories: {"can't be blank", [validation: :required]}
                  ]
                },
                status: :bad_request
              }} = response
    end
  end

  describe "get/1" do
    test "when there is an user with the given id, returns the meal from the database." do
      %Meal{id: id} = insert(:meal)

      response = ExMeal.get_meal_by_id(id)

      assert {:ok,
              %Meal{
                calories: "100 kcal",
                date: ~N[2016-04-16 13:30:15],
                description: "1 Ovo",
                id: "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8",
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "when there is no an user with the given id, returns an error." do
      response = ExMeal.get_meal_by_id("1e459e18-5847-4832-8aeb-4c29a869b7be")

      assert {:error, %Error{result: "Meal not found!", status: :not_found}} = response
    end
  end
end
