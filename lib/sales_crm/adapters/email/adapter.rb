# frozen_string_literal: true

module SalesCRM
  module Adapters
    module Email
      class Adapter
        def send(to:, subject:, body:)
          raise NotImplementedError
        end
      end
    end
  end
end
