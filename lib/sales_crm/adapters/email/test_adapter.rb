# frozen_string_literal: true

module SalesCRM
  module Adapters
    module Email
      class TestAdapter < Adapter
        attr_reader :sent
        def initialize
          @sent = []
        end
        def send(to:, subject:, body:)
          @sent << { to: to, subject: subject, body: body, at: Time.now }
          SalesCRM.logger.info("email[test]: to=#{to} subject="#{subject}"")
          true
        end
      end
    end
  end
end
