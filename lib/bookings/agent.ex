defmodule Booking.Bookings.Agent do
  alias Booking.Bookings.Booking
  use Agent

  def start_link(state \\ %{}) do
    Agent.start_link(fn -> state end, name: __MODULE__)
  end

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &update_state(&1, booking))

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  defp update_state(state, %Booking{id: id} = booking),
    do: Map.put(state, id, booking)

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Flight Booking not found"}
      booking -> {:ok, booking}
    end
  end
end
