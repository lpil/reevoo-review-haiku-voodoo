defmodule RRHVTest do
  use ExUnit.Case
  use ShouldI

  with "to_phrases" do
    should "the truth" do
      assert 1 + 1 == 2
    end
  end
end
