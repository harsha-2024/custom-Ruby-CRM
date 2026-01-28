# frozen_string_literal: true

module SalesCRM
  module Domain
    module Entities
      class Contact
        attr_accessor :id, :account_id, :first_name, :last_name, :email, :phone, :title
        def initialize(id:, account_id:, first_name:, last_name:, email: nil, phone: nil, title: nil)
          @id = id
          @account_id = account_id
          @first_name = first_name
          @last_name = last_name
          @email = email
          @phone = phone
          @title = title
        end
      end
    end
  end
end
