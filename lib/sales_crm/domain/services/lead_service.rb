# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class LeadService
        def initialize(leads_repo:, accounts_repo:, contacts_repo:, logger: SalesCRM.logger)
          @leads = leads_repo
          @accounts = accounts_repo
          @contacts = contacts_repo
          @logger = logger
        end

        def create_lead(name:, company: nil, email: nil, phone: nil, source: nil, owner_id: nil)
          lead = Entities::Lead.new(id: Utils::UUID.v4, name: name, company: company, email: email, phone: phone, source: source, owner_id: owner_id)
          @leads.create(lead)
          @logger.info("lead: created #{lead.id} #{lead.name}")
          lead
        end

        def qualify(lead_id:, rating: 'A')
          lead = fetch(lead_id)
          lead.status = :qualified
          lead.rating = rating
          @leads.update(lead)
          lead
        end

        def convert(lead_id:)
          lead = fetch(lead_id)
          raise SalesCRM::ValidationError, 'lead must be qualified before conversion' unless lead.status == :qualified
          account = Entities::Account.new(id: Utils::UUID.v4, name: lead.company || lead.name)
          contact = Entities::Contact.new(id: Utils::UUID.v4, account_id: account.id, first_name: lead.name.split(' ', 2)[0], last_name: lead.name.split(' ', 2)[1] || '', email: lead.email, phone: lead.phone)
          @accounts.create(account)
          @contacts.create(contact)
          lead.status = :converted
          @leads.update(lead)
          @logger.info("lead: converted #{lead.id} -> account #{account.id}, contact #{contact.id}")
          { account: account, contact: contact, lead: lead }
        end

        def disqualify(lead_id:, reason: nil)
          lead = fetch(lead_id)
          lead.status = :disqualified
          lead.notes = reason
          @leads.update(lead)
          lead
        end

        private
        def fetch(id)
          lead = @leads.find(id)
          raise SalesCRM::NotFound, 'lead not found' unless lead
          lead
        end
      end
    end
  end
end
