defmodule Shared.IsRuleSpec do
  use ESpec, async: true, shared: true

  import Brex.Assertions.Rule

  let_overridable rule_type: :any
  let_overridable [:valid_rules, :invalid_rules]

  describe ".is_rule_for_type?" do
    context "for valid rules" do
      it "be rules" do
        valid_rules()
        |> List.wrap()
        |> Enum.each(fn rule ->
          expect rule |> to(be_rule(rule_type()))
        end)
      end
    end

    context "for invalid rules" do
      it "should return false" do
        invalid_rules()
        |> List.wrap()
        |> Enum.each(fn rule ->
          expect rule |> to_not(be_rule(rule_type()))
        end)
      end
    end
  end
end
