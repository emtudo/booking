defmodule Booking.Users.CreateOrUpdate do
  alias Booking.Users
  alias Users.Agent, as: UserAgent
  alias Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    name
    |> User.build(email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, user.id}
  end

  defp save_user({:error, _reason} = error), do: error
end
