defmodule Booking.Users.UserTest do
  use ExUnit.Case
  alias Booking.Users.User
  import Booking.Factory

  describe "build/3" do
    test "when all params are valid, returns the user" do
      user = build(:user)
      {:ok, response} = User.build(user.name, user.email, user.cpf)

      assert user.name == response.name
      assert user.email == response.email
      assert user.cpf == response.cpf
    end
  end
end
