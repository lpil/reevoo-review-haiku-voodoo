defmodule RRHV.Syllables do
  def start_link(syldict \\ "syldict") do
    load_syldict!(syldict)
    {:ok, self}
  end

  def count("") do
    0
  end

  def count(word) do
    word = String.upcase( word )
    case :ets.lookup( :syllables, word ) do
      [{_, count}] ->
        {count, _} = Integer.parse( count )
        count
      _ ->
        nil
    end
  end

  defp load_syldict!(syldict) do
    :ets.new( :syllables, [:named_table] )
    syldict = File.stream!( syldict )

    Enum.each syldict, fn line ->
      [word, count] = String.split( line )
      :ets.insert( :syllables, {word, count} )
    end
    
  end
end
