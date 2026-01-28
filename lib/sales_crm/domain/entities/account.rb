# frozen_string_literal: true

module SalesCRM
  module Domain
    module Entities
      class Account
        attr_accessor :id, :name, :industry, :billing_address, :shipping_address, :owner_id
        def initialize(id:, name:, industry: nil, billing_address: nil, shipping_address: nil, owner_id: nil)
          @id = id
          @name = name
          @industry = industry
          @billing_address = billing_address
          @shipping_address = shipping_address
          @owner_id = owner_id
        end
      end
    end
  end
end
