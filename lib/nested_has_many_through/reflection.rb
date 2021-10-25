module NestedHasManyThrough
  module Reflection # :nodoc:
    def self.included(base)
      base.send :alias_method, :check_validity_without_nested_has_many_through!, :check_validity!
      base.send :alias_method, :check_validity!, :check_validity_with_nested_has_many_through!
    end

    def check_validity_with_nested_has_many_through!
      check_validity_without_nested_has_many_through!
    rescue ActiveRecord::HasManyThroughSourceAssociationMacroError => e
      # now we permit has many through to a :though source
      raise e unless source_reflection.options[:through]
    end
  end
end
