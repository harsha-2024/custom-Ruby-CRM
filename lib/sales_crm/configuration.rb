# frozen_string_literal: true

module SalesCRM
  class Configuration
    attr_accessor :currency, :logger, :email_adapter
    attr_reader :repositories

    def initialize
      @currency = 'USD'
      @logger = TaggedLogger.new($stdout)
      @repositories = {
        leads: nil,
        accounts: nil,
        contacts: nil,
        products: nil,
        opportunities: nil,
        quotes: nil,
        activities: nil
      }
    end
  end
end
