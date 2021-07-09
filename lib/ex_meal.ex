defmodule ExMeal do
  @moduledoc false

  alias ExMeal.Meals.Create, as: CreateMeal
  alias ExMeal.Meals.Delete, as: DeleteMeal
  alias ExMeal.Meals.Get, as: GetMeal
  alias ExMeal.Meals.Update, as: UpdateMeal

  alias ExMeal.Users.Create, as: CreateUser
  alias ExMeal.Users.Get, as: GetUser
  alias ExMeal.Users.Delete, as: DeleteUser
  alias ExMeal.Users.Update, as: UpdateUser

  defdelegate create_meal(meal_params), to: CreateMeal, as: :call
  defdelegate get_meal_by_id(meal_id), to: GetMeal, as: :by_id
  defdelegate delete_meal(meal_id), to: DeleteMeal, as: :call
  defdelegate update_meal(meal_id, meal_params), to: UpdateMeal, as: :call

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate delete_user(id), to: DeleteUser, as: :call
  defdelegate update_user(id, params), to: UpdateUser, as: :call
end
