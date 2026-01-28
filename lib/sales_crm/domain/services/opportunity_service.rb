# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class OpportunityService
        STAGE_PROBABILITY = {
          prospecting: 0.1,
          qualification: 0.2,
          proposal: 0.5,
          negotiation: 0.7,
          closed_won: 1.0,
          closed_lost: 0.0
        }

        def initialize(opps_repo:, quotes_repo:, logger: SalesCRM.logger)
          @opps = opps_repo
          @quotes = quotes_repo
          @logger = logger
        end

        def create_opportunity(account_id:, name:, contact_id: nil, stage: :prospecting, owner_id: nil)
          opp = Entities::Opportunity.new(id: Utils::UUID.v4, account_id: account_id, name: name, contact_id: contact_id, stage: stage, amount_cents: 0, probability: STAGE_PROBABILITY[stage] || 0.1, owner_id: owner_id)
          @opps.create(opp)
          opp
        end

        def link_quote(opportunity_id:, quote_id:)
          opp = fetch(opportunity_id)
          opp.quote_id = quote_id
          recalc_amount!(opp)
          @opps.update(opp)
          opp
        end

        def advance_stage(opportunity_id:)
          opp = fetch(opportunity_id)
          stages = SalesCRM::Types::OPPORTUNITY_STAGES
          idx = stages.index(opp.stage) || 0
          opp.stage = stages[[idx + 1, stages.length - 1].min]
          opp.probability = STAGE_PROBABILITY[opp.stage]
          @opps.update(opp)
          @logger.info("opportunity: #{opp.id} advanced to #{opp.stage}")
          opp
        end

        def set_stage(opportunity_id:, stage:)
          opp = fetch(opportunity_id)
          opp.stage = stage
          opp.probability = STAGE_PROBABILITY[stage] || opp.probability
          @opps.update(opp)
          opp
        end

        def recalc_amount!(opp)
          return unless opp.quote_id
          q = @quotes.find(opp.quote_id)
          opp.amount_cents = q ? q.total_cents : 0
          opp.probability = STAGE_PROBABILITY[opp.stage] || opp.probability
        end

        private
        def fetch(id)
          opp = @opps.find(id)
          raise SalesCRM::NotFound, 'opportunity not found' unless opp
          opp
        end
      end
    end
  end
end
