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
        """, ignore_punctuation: true
      end

      should "recognise 17 punctuated syllables as a haiku" do
        assert RRHV.haiku? """
        a a a a
        a a a, a a a a. a a!! a a a.
        a
        """, ignore_punctuation: true
      end

      should "recognise 7 syllables as not a haiku" do
        refute RRHV.haiku? """
        a a a a a a a
        """, ignore_punctuation: true
      end

      should "recognise 8 punctuated syllables as a haiku" do
        refute RRHV.haiku? """
        a 
        a, a a. a a!! a.
        a
        """, ignore_punctuation: true
      end
    end

  end

  should "be able to query db without crashing" do
    RRHV.Reviews.get
  end
end
