defmodule BananaBankWeb.UsersJSON do
    alias BananaBank.Users.User

    # def create(%{user: user}) do
    #     # Teste on web "mix phx.server"
    #     %{
    #         message: "Usuário criado com sucesso!",
    #         data: data(user)
    #     }
    # end
    
    def login(%{token: token}), do: %{message: "User autenticado com sucesso!", bearer: token}
    def create(%{user: user}), do: %{message: "User criar com sucesso!", data: data(user)}
    def delete(%{user: user}), do: %{message: "User deletado com sucesso!", data: data(user)}
    def get(%{user: user}), do: %{data: data(user)}
    def update(%{user: user}), do: %{message: "User atualizado com sucesso!", data: data(user)}

    defp data(%User{} = user) do
        %{
            name: user.name,
            id: user.id,
            cep: user.cep,
            email: user.email
        }
    end
end