# frozen_string_literal: true

module Manufacturer
  def  give_company_name(name)
    self.company = name
  end

  def company_name
    company
  end

  protected

  attr_accessor :company
end
