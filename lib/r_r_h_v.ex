defmodule RRHV do
end

defmodule RRHV.Reviews do
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
    LIMIT 100
    OFFSET ?;
  """

  def init do
    {:ok, db} = DB.start_link( username: "root", database: "revieworld_live" )
    db
  end

  def get(db, offset \\ 0) do
    {:ok, result} = DB.query( db, @query, [offset] )
    niceify result
  end

  defp niceify(result) do
    cols = Enum.map( result.columns, &String.to_atom(&1) )
    Enum.map result.rows, fn row ->
      vals = Tuple.to_list( row )
      Enum.zip( cols, vals )
      |> Enum.into(%{})
    end
  end
end

defmodule RRHV.Syllables do
  def init(syldict \\ "syldict") do
    :ets.new( :syllables, [:named_table] )
    syldict = File.stream!( syldict )

    Enum.each syldict, fn line ->
      [word, count] = String.split( line )
      :ets.insert( :syllables, {word, count} )
    end
  end

  def count(word) do
    word = String.upcase( word )
    case :ets.lookup( :syllables, word ) do
      [{_, count}] ->
        {count, _} = Integer.parse( count )
        count
      _ -> nil
    end
  end
end
