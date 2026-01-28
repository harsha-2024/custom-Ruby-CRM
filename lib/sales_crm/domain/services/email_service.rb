# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class EmailService
        def initialize(adapter: SalesCRM.configuration.email_adapter, logger: SalesCRM.logger)
          @adapter = adapter
          @logger = logger
        end
        def send(to:, subject:, body:)
          @adapter.send(to: to, subject: subject, body: body)
        end
      end
    end
  end
end
