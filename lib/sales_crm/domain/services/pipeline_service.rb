# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class PipelineService
        def initialize(opps_repo:, logger: SalesCRM.logger)
          @opps = opps_repo
          @logger = logger
        end

        def weighted_pipeline
          data = {} # stage => {count:, total_cents:, weighted_cents:}
          SalesCRM::Types::OPPORTUNITY_STAGES.each do |stage|
            data[stage] = { count: 0, total_cents: 0, weighted_cents: 0 }
          end
          @opps.all.each do |o|
            rec = data[o.stage]
            rec[:count] += 1
            rec[:total_cents] += o.amount_cents
            rec[:weighted_cents] += (o.amount_cents * o.probability).round
          end
          data
        end
      end
    end
  end
end
