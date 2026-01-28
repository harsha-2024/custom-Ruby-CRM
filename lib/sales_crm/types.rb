# frozen_string_literal: true

module SalesCRM
  module Types
    OPPORTUNITY_STAGES = %i[prospecting qualification proposal negotiation closed_won closed_lost].freeze
    ACTIVITY_TYPES = %i[task call email meeting].freeze
    QUOTE_STATUSES = %i[draft sent accepted rejected].freeze
    LEAD_STATUSES = %i[new qualified converted disqualified].freeze
  end
end
