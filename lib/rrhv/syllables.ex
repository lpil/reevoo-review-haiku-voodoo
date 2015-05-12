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
