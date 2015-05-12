defmodule RRHV do
  def haiku?(words) do
    false
  end

  defp to_phrases(prose) do
    String.split( prose, ~r/[\.,!;\n]/, trim: true )
  end

  defp to_words(phrase) do
    String.split( phrase, ~r/[^\w]/, trim: true )
  end
end
