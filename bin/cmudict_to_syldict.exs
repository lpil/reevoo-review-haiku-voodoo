cmudict = File.stream!( "cmudict" )
{:ok, syldict} = File.open( "syldict", [:write] )

starts_with_vowel = &String.match?( &1, ~r/\A[AEIOU]/ )

for line <- cmudict do
  if starts_with_vowel.(line) do
    [word|syls] = String.split( line )
    count       = Enum.filter( syls, starts_with_vowel ) |> length
    IO.write( syldict, "#{ word } #{ count }\n" )
  end
end

File.close( cmudict )
File.close( syldict )
