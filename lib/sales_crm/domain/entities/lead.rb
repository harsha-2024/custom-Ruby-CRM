# frozen_string_literal: true

module SalesCRM
  module Domain
    module Entities
      class Lead
        attr_accessor :id, :name, :company, :email, :phone, :status, :rating, :source, :owner_id, :notes
        def initialize(id:, name:, company: nil, email: nil, phone: nil, status: :new, rating: nil, source: nil, owner_id: nil, notes: nil)
          @id = id
          @name = name
          @company = company
          @email = email
          @phone = phone
          @status = status
          @rating = rating
          @source = source
          @owner_id = owner_id
          @notes = notes
        end
      end
    end
  end
end
