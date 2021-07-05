defmodule ExMealTest do
  use ExMeal.DataCase, async: true

  import ExMeal.Factory

  alias ExMeal.Error
  alias ExMeal.Meals.Meal
  alias ExMeal.Users.User

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

  describe "get_meal_by_id/1" do
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

  describe "delete_meal/1" do
    test "When there is a user with the given ID, deletes the user." do
      %Meal{id: id} = insert(:meal)

      response = ExMeal.delete_meal(id)

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

    test "When there is no a user with the given ID, returns an error." do
      response = ExMeal.delete_meal("1e459e18-5847-4832-8aeb-4c29a869b7be")

      assert {:error, %Error{result: "Meal not found!", status: :not_found}} = response
    end
  end

  describe "update_meal/2" do
    test "When all params are valid and there is a user with the given ID, updates the user" do
      %Meal{id: id} = insert(:meal)

      params = %{
        calories: "200 kcal",
        date: "2016-05-10 12:20:10",
        description: "2 Ovos"
      }

      response = ExMeal.update_meal(id, params)

      assert {:ok,
              %Meal{
                calories: "200 kcal",
                date: ~N[2016-05-10 12:20:10],
                description: "2 Ovos",
                id: "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8",
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "When there is no a user with the given ID, returns an error" do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      params = %{
        calories: "200 kcal",
        date: "2016-05-10 12:20:10",
        description: "2 Ovos"
      }

      response = ExMeal.update_meal(id, params)

      assert {:error, %Error{result: "Meal not found!", status: :not_found}} = response
    end

    test "When some param is invalid, returns an error" do
      %Meal{id: id} = insert(:meal)

      params = %{
        calories: "",
        date: "",
        description: ""
      }

      response = ExMeal.update_meal(id, params)

      assert {
               :error,
               %Error{
                 result: %Ecto.Changeset{
                   action: :update,
                   changes: %{},
                   errors: [
                     description: {"can't be blank", [validation: :required]},
                     date: {"can't be blank", [validation: :required]},
                     calories: {"can't be blank", [validation: :required]}
                   ],
                   valid?: false
                 },
                 status: :bad_request
               }
             } = response
    end
  end

  describe "create_user/1" do
    test "When all params are valid, inserts a user into the database." do
      params = build(:user_params)

      response = ExMeal.create_user(params)

      assert {:ok,
              %User{
                cpf: "001.324.030-23",
                email: "maiqui@email.com",
                id: _id,
                inserted_at: _inserted_at,
                name: "Maiqui Pirolli Tomé",
                updated_at: _updated_at
              }} = response
    end

    test "When any parameter is blank, returns an error" do
      params = %{
        cpf: "",
        email: "",
        name: ""
      }

      response = ExMeal.create_user(params)

      assert {
               :error,
               %Error{
                 result: %Ecto.Changeset{
                   action: :insert,
                   changes: %{},
                   errors: [
                     name: {"can't be blank", [validation: :required]},
                     cpf: {"can't be blank", [validation: :required]},
                     email: {"can't be blank", [validation: :required]}
                   ],
                   valid?: false
                 },
                 status: :bad_request
               }
             } = response
    end

    test "When the email parameter is invalid, returns an error" do
      params = build(:user_params, email: "maiquitome.com")

      response = ExMeal.create_user(params)

      assert {:error,
              %Error{
                result: %Ecto.Changeset{
                  action: :insert,
                  changes: %{
                    cpf: "001.324.030-23",
                    email: "maiquitome.com",
                    name: "Maiqui Pirolli Tomé"
                  },
                  errors: [email: {"has invalid format", [validation: :format]}],
                  valid?: false
                },
                status: :bad_request
              }} = response
    end
  end
end
