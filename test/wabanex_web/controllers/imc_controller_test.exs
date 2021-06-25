defmodule WabanexWeb.IMCControllerTest do
	use WabanexWeb.ConnCase

	describe "index/2" do
		test "when all params are valid, returns the imc info", %{conn: conn} do
			params = %{"filename" => "students.csv"}

			response =
				conn
				|> get(Routes.imc_path(conn, :index, params))
				|> json_response(:ok)

			expected_response = %{"result" => %{"Gabriel" => 26.82742078020452}}

			assert expected_response == response
		end

		test "when there are invalid params, returns an error", %{conn: conn} do
			params = %{"filename" => "banana.csv"}

			response =
				conn
				|> get(Routes.imc_path(conn, :index, params))
				|> json_response(:bad_request)

			expected_response = %{"result" => "error while opening the file"}

			assert expected_response == response
		end
	end

end
