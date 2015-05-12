defmodule RRHV do
  use Application

  def start(_type, _args) do
    RRHV.Syllables.start_link
  end

  def haiku?(prose, ignore_punctuation: true) do
    17 == prose
        |> to_words
        |> Enum.map( &RRHV.Syllables.count(&1) )
        |> Enum.sum
  end


  def haiku?(prose) do
    haiku?(prose, ignore_punctuation: false)
  end

  def haiku?(prose, ignore_punctuation: false) do
    raise "Not yet implemented"
  end


  defp to_phrases(prose) do
    String.split( prose, ~r/[\.,!;\n]/, trim: true )
  end

  defp to_words(phrase) do
    String.split( phrase, ~r/[^\w]/, trim: true )
  end
end
