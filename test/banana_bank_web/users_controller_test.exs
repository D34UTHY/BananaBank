defmodule BananaBankWeb.UsersController.Test do
    use BananaBankWeb.ConnCase

    import Mox

    alias BananaBank.Users
    alias Users.User

    setup do
        params = %{
                "name" => "Matheus",
                "cep" => "12345678",
                "email" => "matheus@bananabank.com",
                "password" => "123456" # Do NOT use this password XD
            }

        body = %{
                "bairro" => "",
                "cep" => "12345-678",
                "complemento" => "",
                "ddd" => "00",
                "gia" => "",
                "ibge" => "",
                "localidade" => "localidade",
                "logradouro" => "logradouro",
                "siafi" => "1234",
                "uf" => "AA"
            }

        {:ok, %{user_params: params, body: body}}
    end

    describe "create/2" do
        test "successfully creates an user", %{conn: conn, user_params: params, body: body} do
            expect(BananaBank.ViaCep.ClientMock, :call, fn 12345678 -> 
                {:ok, body}
            end)

            response = 
                conn
                |> post(~p"/api/users", params)
                |> json_response(:created)

            assert %{
                "data" => %{"cep" => "12345678", "email" => "matheus@bananabank.com", "id" => _id, "name" => "Matheus"}, "message" => "User criado com sucesso!"
                 } = response
        end

        test "when there are invalid params, returns an error", %{conn: conn} do
            params = %{
                name: nil,
                cep: "12",
                email: "matheus@bananabank.com",
                password: "12345678"
            }

            expect(BananaBank.ViaCep.ClientMock, :call, fn "12" -> 
                {:ok, ""}
            end)

            response = 
            conn
            |> post(~p"/api/users", params)
            |> json_response(:bad_request)

            expected_response = %{"errors" => %{"cep" => ["should be 8 character(s)"], "name" => ["Can't be blank"]}}

            assert response == expected_response
        end
    end

    describe "delete/2" do
        test "successfully deletes an user", %{conn: conn, user_params: params, body: body} do
            expect(BananaBank.ViaCep.ClientMock, :call, fn 12345678 -> 
                {:ok, body}
            end)

            {:ok, %User{id: id}} = Users.create(params)

            response = 
            conn
            |> delete(~p"/api/users/#{id}")
            |> json_response(:ok)

            expected_response = %{
                "data" => &{"cep" => "12345678", "email" => "matheus@bananabank.com", "id" => id, "name" => "Matheus"}
            }

            assert response == expected_response
        end
    end
end