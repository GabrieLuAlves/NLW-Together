defmodule WabanexWeb.SchemaTest do
	use WabanexWeb.ConnCase, async: true

	alias Wabanex.User
	alias Wabanex.Users.Create

	describe "users queries" do
		test "when a valid id is given, return the user", %{conn: conn} do
			params = %{email: "gabrielluan.valentim@gmail.com", name: "GabrielLuan", password: "123456"}

			{:ok, %User{id: user_id}} = Create.call(params)

			query = """
			{
				getUser(id: "#{user_id}") {
					name,
					email,
				}
			}
			"""

			response =
				conn
				|> post("/api/graphql", %{query: query})
				|> json_response(:ok)

			expected_response = %{"data" => %{"getUser" => %{"email" => "gabrielluan.valentim@gmail.com", "name" => "GabrielLuan"}}}

			assert expected_response == response
		end
	end

	describe "users mutations" do
		test "when all params are valid, creates the user", %{conn: conn} do
			mutation = """
				mutation {
					createUser(input:{name: "GabrielLuan00", email:"gabrielluan-2204@hotmail.com", password:"senha123"}){
						id
						name
					}
				}
			"""

			response =
				conn
				|> post("/api/graphql", %{query: mutation})
				|> json_response(:ok)

			assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "GabrielLuan00"}}} = response
		end
	end
end
