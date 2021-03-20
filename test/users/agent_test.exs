defmodule Booking.Users.AgentTest do
  use ExUnit.Case
  alias Booking.Users.Agent, as: UserAgent
  use Agent

  import Booking.Factory

  describe "save/1" do
    setup do
      UserAgent.start_link()

      :ok
    end

    test "saves the user" do
      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      id = "12345678901"

      {:ok, id: id}
    end

    test "when the user is found, returns the user", %{id: id} do
      user = build(:user, id: id)
      UserAgent.save(user)

      {:ok, response} = UserAgent.get(id)

      assert response == user
    end

    test "when the user is not found, returns an error", %{id: id} do
      response = UserAgent.get(id)

      assert response == {:error, "User not found"}
    end
  end
end
