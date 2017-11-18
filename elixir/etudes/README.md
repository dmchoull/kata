# Études for Elixir

http://chimera.labs.oreilly.com/books/1234000001642/pr02.html

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add exercises to your list of dependencies in `mix.exs`:

        def deps do
          [{:exercises, "~> 0.0.1"}]
        end

  2. Ensure exercises is started before your application:

        def application do
          [applications: [:exercises]]
        end

