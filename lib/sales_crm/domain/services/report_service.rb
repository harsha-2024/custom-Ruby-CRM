# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class ReportService
        def initialize(opps_repo:, leads_repo:, quotes_repo:, logger: SalesCRM.logger)
          @opps = opps_repo
          @leads = leads_repo
          @quotes = quotes_repo
          @logger = logger
        end

        def win_rate
          won = @opps.all.count { |o| o.stage == :closed_won }
          lost = @opps.all.count { |o| o.stage == :closed_lost }
          total = won + lost
          return 0.0 if total == 0
          (won.to_f / total).round(2)
        end

        def average_deal_size
          deals = @opps.all.select { |o| o.stage == :closed_won }
          return 0 if deals.empty?
          (deals.sum(&:amount_cents) / deals.size.to_f).round
        end

        def quote_conversion_rate
          sent = @quotes.all.count { |q| q.status == :sent }
          accepted = @quotes.all.count { |q| q.status == :accepted }
          return 0.0 if sent == 0
          (accepted.to_f / sent).round(2)
        end
      end
    end
  end
end
