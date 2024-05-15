defmodule BananaBank.ViaCep.ClientTest do
    use ExUnit.Case, async: true

    alias BananaBank.ViaCep.Client

    setup do
        bypass = Bypass.open()
        {:ok, bypass: bypass}
    end

    describe "call/1" do
        test "Successfully returns cep info", %{bypass: bypass} do
            cep = "12345678"
            body = ~s({
                "bairro": "",
                "cep": "00000-000"
                "complemento": "",
                "ddd": "21",
                "gia": "",
                "ibge": "4213415",
                "localidade": "Rio de Janeiro",
                "logradouro": "",
                "siafi": "1234",
                "uf": "RJ"
            })
            expected_response = 
            {:ok,
            %{
                "bairro" => "",
                "cep" => "00000-000"
                "complemento" => "",
                "ddd" => "21",
                "gia" => "",
                "ibge" => "4213415",
                "localidade" => "Rio de Janeiro",
                "logradouro" => "",
                "siafi" => "1234",
                "uf" => "RJ"
            }}

            Bypass.expect(bypass, "GET", "/00000000/json", fn conn -> 
                conn
                |> Plug.Conn.put_resp_content_type("application/json")
                |> Plug.Conn.resp(200, body)
            send)

            reponse = 
            bypass.port
            |> endpoint_url()
            |> Client.call(cep)

            assert response == expected_response
        end
    end

    defp endpoint_url(port), do: "http://localhost:#{port}"
end