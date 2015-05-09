cmudict        = File.stream!( "cmudict" )
{:ok, syldict} = File.open( "syldict", [:write] )

starts_with_letter = &String.match?( &1, ~r/\A[A-Z]/ )
starts_with_vowel  = &String.match?( &1, ~r/\A[AEIOU]/ )

for line <- cmudict do
  if starts_with_letter.(line) do
    [word|syls] = String.split( line )
    count       = Enum.filter( syls, starts_with_vowel ) |> length

    if String.valid?( word ) do
      IO.write( syldict, "#{ word } #{ count }\n" )
    end
  end
end
