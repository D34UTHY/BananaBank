defmodule BananaBank.Users.Verify do
    alias BananaBank.Users
    alias Users.User

    def call(%{"id" => id "password" => password}) do
        case User.get(id) do
            {:ok, user} -> verify(user, password)
            {:error, _} = error -> error
        end
    end

    defp verify(user, password) do
        case Argon2.verify_pass(password, user.password_hash) do
            true -> {:ok, user}
            false -> {:error, :unauthorized}
        end
    end
end