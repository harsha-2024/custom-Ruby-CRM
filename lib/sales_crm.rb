# frozen_string_literal: true

require 'logger'

require_relative 'sales_crm/version'
require_relative 'sales_crm/errors'
require_relative 'sales_crm/logger'
require_relative 'sales_crm/configuration'
require_relative 'sales_crm/types'

# Utils
require_relative 'sales_crm/utils/uuid'

# Value Objects
require_relative 'sales_crm/domain/value_objects/money'
require_relative 'sales_crm/domain/value_objects/email'
require_relative 'sales_crm/domain/value_objects/phone'
require_relative 'sales_crm/domain/value_objects/address'

# Entities
require_relative 'sales_crm/domain/entities/lead'
require_relative 'sales_crm/domain/entities/account'
require_relative 'sales_crm/domain/entities/contact'
require_relative 'sales_crm/domain/entities/product'
require_relative 'sales_crm/domain/entities/opportunity'
require_relative 'sales_crm/domain/entities/quote'
require_relative 'sales_crm/domain/entities/activity'

# Repositories (in-memory)
require_relative 'sales_crm/domain/repositories/in_memory/leads_repository'
require_relative 'sales_crm/domain/repositories/in_memory/accounts_repository'
require_relative 'sales_crm/domain/repositories/in_memory/contacts_repository'
require_relative 'sales_crm/domain/repositories/in_memory/products_repository'
require_relative 'sales_crm/domain/repositories/in_memory/opportunities_repository'
require_relative 'sales_crm/domain/repositories/in_memory/quotes_repository'
require_relative 'sales_crm/domain/repositories/in_memory/activities_repository'

# Services
require_relative 'sales_crm/domain/services/lead_service'
require_relative 'sales_crm/domain/services/account_service'
require_relative 'sales_crm/domain/services/contact_service'
require_relative 'sales_crm/domain/services/product_service'
require_relative 'sales_crm/domain/services/quote_service'
require_relative 'sales_crm/domain/services/opportunity_service'
require_relative 'sales_crm/domain/services/activity_service'
require_relative 'sales_crm/domain/services/email_service'
require_relative 'sales_crm/domain/services/pipeline_service'
require_relative 'sales_crm/domain/services/report_service'

# Adapters
require_relative 'sales_crm/adapters/email/adapter'
require_relative 'sales_crm/adapters/email/test_adapter'

module SalesCRM
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def logger
      configuration.logger
    end
  end
end
