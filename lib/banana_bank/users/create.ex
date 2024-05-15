defmodule BananaBank.Users.Create do
    alias BananaBank.User.User
    alias BananaBank.Repo
    alias BananaBank.ViaCep.Client, as ViaCepClient

    # Make it easier to create new users and verify if they are correctly created before insert on db
    # On terminal: Create.call(params)
    def call(%{"cep" => cep} = params) do
    with {:ok, _result} <- client().call(cep) do
            params
            |> User.changeset()
            |> Repo.insert()
        end 
    end

    defp client() do
        Application.get_env(:banana_bank, :via_cep_client, ViaCepClient)
    end
end