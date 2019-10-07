defmodule HTTPingWeb.PageControllerTest do
  use HTTPingWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "httping"
  end
end
