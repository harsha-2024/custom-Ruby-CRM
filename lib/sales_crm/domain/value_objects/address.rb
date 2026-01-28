# frozen_string_literal: true

module SalesCRM
  module Domain
    module ValueObjects
      Address = Struct.new(:line1, :line2, :city, :state, :postal_code, :country, keyword_init: true)
    end
  end
end
