defmodule RRHV do
  use Application

  def start(_type, _args) do
    RRHV.Syllables.start_link
  end

  def haiku?(prose) do
    haiku?(prose, ignore_punctuation: false)
  end

  def haiku?(prose, ignore_punctuation: true) do
    17 == syllables_in_line( prose )
  end

  def haiku?(prose, ignore_punctuation: false) do
    [5, 7, 5] == prose
                |> to_phrases
                |> Enum.map( &syllables_in_line(&1) )
  end


  defp to_phrases(prose) do
    String.split( prose, ~r/[\.\?,!;\n]/, trim: true )
  end

  defp to_words(phrase) do
    String.split( phrase, ~r/[^\w]/, trim: true )
  end

  defp syllables_in_line(line) do
    line
    |> to_words
    |> Enum.map( &RRHV.Syllables.count(&1) )
    |> Enum.sum
  end
end
