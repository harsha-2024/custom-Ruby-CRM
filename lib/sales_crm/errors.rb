# frozen_string_literal: true

module SalesCRM
  class Error < StandardError; end
  class NotFound < Error; end
  class ValidationError < Error; end
end
