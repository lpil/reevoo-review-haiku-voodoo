defmodule RRHV.Reviews do
  use GenServer

  alias Mariaex.Connection, as: DB

  @query """
  SELECT id, first_name, good_points, bad_points, general_comments
  FROM reviews
  WHERE
    (
      good_points IS NOT NULL
      OR bad_points IS NOT NULL
      OR general_comments IS NOT NULL
    )
  LIMIT ?
  OFFSET ?;
  """

  def start_link do
    GenServer.start_link( __MODULE__, :ok, name: Reviews )
  end

  def get(num \\ 20) do
    get num, offset: 0
  end

  def get(num, offset: offset) do
    args = [num, offset]
    GenServer.call( Reviews, {:get, args} )
  end


  ###############
  #  Callbacks  #
  ###############

  def init(:ok) do
    DB.start_link( username: "root", database: database )
  end

  def handle_call({:get, args}, _from, db) do
    {:ok, result} = DB.query( db, @query, args )
    result = niceify result
    {:reply, result, db}
  end


  ###########
  #  Logic  #
  ###########

  defp database do
    case Mix.env do
      :test -> "rrhv_test"
      _     -> "revieworld_live"
    end
  end

  defp niceify(result) do
    cols = result.columns |> Enum.map( &String.to_atom(&1) )
    Enum.map result.rows, fn row ->
      vals = Tuple.to_list( row )
      Enum.zip( cols, vals )
      |> Enum.into(%{})
    end
  end
end
