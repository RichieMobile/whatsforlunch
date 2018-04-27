defmodule WhatsforlunchWeb.PageController do
  use WhatsforlunchWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
