# frozen_string_literal: true

module SalesCRM
  module Domain
    module Entities
      class Opportunity
        attr_accessor :id, :account_id, :contact_id, :name, :stage, :amount_cents, :probability, :close_date, :owner_id, :quote_id
        def initialize(id:, account_id:, name:, contact_id: nil, stage: :prospecting, amount_cents: 0, probability: 0.1, close_date: nil, owner_id: nil, quote_id: nil)
          @id = id
          @account_id = account_id
          @contact_id = contact_id
          @name = name
          @stage = stage
          @amount_cents = amount_cents
          @probability = probability
          @close_date = close_date
          @owner_id = owner_id
          @quote_id = quote_id
        end
      end
    end
  end
end
