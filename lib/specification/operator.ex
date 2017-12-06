defmodule Specification.Operator do
  @moduledoc false

  rules = [:all, :any, :negate]

  for rule <- rules do
    def unquote(rule)(rules) do
      {unquote(rule), List.wrap(rules)}
    end

    def unquote(rule)(arg1, arg2) do
      unquote(rule)([arg1, arg2])
    end
  end
end