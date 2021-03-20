defmodule Booking.Users.CreateOrUpdateTest do
  use ExUnit.Case
  alias Booking.Users.Agent, as: UserAgent
  alias Booking.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      response =
        CreateOrUpdate.call(%{
          name: "Leandro",
          email: "emtudo@gmail.com",
          cpf: "12345678901"
        })

      assert {:ok, _user_id} = response
    end
  end
end
