defmodule Booking.Users.Agent do
  alias Booking.Users.User
  use Agent

  def start_link(state \\ %{}) do
    Agent.start_link(fn -> state end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  defp update_state(state, %User{id: id} = user),
    do: Map.put(state, id, user)

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
