# frozen_string_literal: true
require 'securerandom'

module SalesCRM
  module Utils
    module UUID
      def self.v4
        SecureRandom.uuid
      end
    end
  end
end
