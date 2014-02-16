defmodule Cookie.SessionMiddleware do
  @behaviour :cowboy_middleware

  @moduledoc """
  Look at all incoming requests and if they don't yet have a session_id cookie, 
  give them one.
  """ 
  def execute(req, env) do
    {cookie_val, req2} = :cowboy_req.cookie("session_id", req)
    req2 = case cookie_val do
      :undefined ->
        session_id = integer_to_list(:random.uniform(1000000))
        :cowboy_req.set_resp_cookie("session_id", session_id, [path: "/"], req)
      _ ->
        req
    end
    {:ok, req2, env}
  end
end
