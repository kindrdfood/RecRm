require 'unitwise'
require 'unitwise/ext'

class IngredientsRecipe < ActiveRecord::Base
	belongs_to :ingredient
	belongs_to :recipe
  accepts_nested_attributes_for :ingredient

#### need to decide what unit types we will allow a user to select from and then we can save the data in the most basic format IE the user may want to enter it in tons, or pounds or ounces but we can save all weight entries as ounces  ####

  ## convert the avalue to a specific unit type when retrieved

  # def amount
  #   read_attribute(:amount).convert_to(self.amount_unit)
  # end

  ## store the value as a specific unit type in the database. Will need to add logic based on what type of unit is inputted

  # def amount=(value)
  #   write_attribute :amount, value.to_tablespoon
  #   if value.respond_to?(:unit)
  #     self.amount_unit = value.unit.to_s
  #   end
  # end

end
