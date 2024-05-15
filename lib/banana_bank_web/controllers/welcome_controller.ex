defmodule BananaBankWeb.WelcomeController do
  Use BananaBankWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(200) # Ou (:ok)
    |> json(%{message: "Bem Vindo ao BananaBank!", status: :ok})
  end
end
