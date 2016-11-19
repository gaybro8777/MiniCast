defmodule SuperTiger.AuthenticationTest do
  use SuperTiger.ModelCase

  alias SuperTiger.{User, Authentication, Repo, Session}

  @opts Authentication.init([])

  def put_auth_token_in_header(conn, token) do
    conn
    |> put_req_header("authorization", "Token token=\"#{token}\"")
  end

  test "finds the user by token", %{conn: conn} do
    user = Repo.insert!(%User{})
    session = Repo.insert!(%Session{token: "123", user_id: user.id})

    conn = conn
    |> put_auth_token_in_header(session.token)
    |> Authentication.call(@opts)

    assert conn.assigns.current_user
  end

  test "invalid token", %{conn: conn} do
    conn = conn
    |> put_auth_token_in_header("foo")
    |> Authentication.call(@opts)

    assert conn.status == 401
    assert conn.halted
  end

  #test "changeset with valid attributes" do
  #  changeset = User.changeset(%User{}, @valid_attrs)
  #  assert changeset.valid?
  #end

  #test "changeset with invalid attributes" do
  #  changeset = User.changeset(%User{}, @invalid_attrs)
  #  refute changeset.valid?
  #end
end
