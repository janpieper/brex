defmodule Brex.Rule.StructSpec do
  use ESpec, async: true

  alias Support.Rules.EqualsRule

  it_behaves_like Shared.EvaluateSpec,
    rule: %EqualsRule{value: 42},
    valid_values: [
      42,
      42.0
    ],
    invalid_values: [
      1,
      1337,
      :a,
      "foo"
    ]

  describe "invalid Struct rules" do
    context "with no evaluate function" do
      let :invalid_rule do
        defmodule NoEvaluateFunction do
          use Brex.Rule.Struct

          defstruct []
        end
      end

      it "should raise a CompileError" do
        expect (&invalid_rule/0)
               |> to(
                 raise_exception CompileError,
                                 "spec/brex/rule/struct_spec.exs:22: cannot use Brex.Rule.Struct on module Brex.Rule.StructSpec.NoEvaluateFunction without defining evaluate/2"
               )
      end
    end

    context "not being a struct" do
      let :invalid_rule do
        defmodule NoStruct do
          use Brex.Rule.Struct

          def evaluate(_, _), do: :ok
        end
      end

      it "should raise a CompileError" do
        expect (&invalid_rule/0) |> to(raise_exception CompileError)
      end
    end
  end
end
