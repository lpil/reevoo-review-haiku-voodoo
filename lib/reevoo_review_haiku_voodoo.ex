defmodule ReevooReviewHaikuVoodoo do
  use GenServer

  def load_syllables do
    :ets.new( :syllables, [:named_table] )
    syldict = File.stream!( "syldict" )

    Enum.each syldict, fn line ->
      [word, count] = String.split( line )
      :ets.insert( :syllables, {word, count} )
    end
  end

  def syllables(word) do
    word = String.upcase( word )
    case :ets.lookup( :syllables, word ) do
      [{_, count}] ->
        {count, _} = Integer.parse( count )
        count
      _ -> nil
    end
  end
end
