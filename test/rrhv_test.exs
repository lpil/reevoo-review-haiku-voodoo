defmodule RRHVTest do
  use ExUnit.Case
  use ShouldI

  with ".haiku?" do
    should "be false for empty strings" do
      refute RRHV.haiku?( "" )
    end

    with "a valid haiku" do
      should "be true when punctuated with newlines" do
        assert RRHV.haiku? """
        one two three four five
        one two three four five six more
        one two three four five
        """
      end

      should "be true when punctuated with full stops" do
        assert RRHV.haiku? """
        one two three four five. \
        one two three four five six more. \
        one two three four five.
        """
      end

      should "be true when punctuated with commas" do
        assert RRHV.haiku? """
        one two three four five, \
        one two three four five six more, \
        one two three four five
        """
      end

      should "be true when punctuated with question marks" do
        assert RRHV.haiku? """
        one two three four five? \
        one two three four five six more? \
        one two three four five
        """
      end

      should "be true when punctuated with exclamation marks" do
        assert RRHV.haiku? """
        one two three four five! \
        one two three four five six more! \
        one two three four five
        """
      end
    end

    with "ignore_punctuation: true" do
      should "recognise 17 syllables as a haiku" do
        assert RRHV.haiku? """
        a a a a a a a a a a a a a a a a a
        """
      end

      should "recognise 17 punctuated syllables as a haiku" do
        assert RRHV.haiku? """
        a a a a
        a a a, a a a a. a a!! a a a.
        a
        """
      end
    end

  end
end
