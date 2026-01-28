# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
require 'sales_crm'

# --- Configure ---
SalesCRM.configure do |c|
  c.currency = 'USD'
  c.email_adapter = SalesCRM::Adapters::Email::TestAdapter.new

  c.repositories[:leads]        = SalesCRM::Domain::Repositories::InMemory::LeadsRepository.new
  c.repositories[:accounts]     = SalesCRM::Domain::Repositories::InMemory::AccountsRepository.new
  c.repositories[:contacts]     = SalesCRM::Domain::Repositories::InMemory::ContactsRepository.new
  c.repositories[:products]     = SalesCRM::Domain::Repositories::InMemory::ProductsRepository.new
  c.repositories[:opportunities]= SalesCRM::Domain::Repositories::InMemory::OpportunitiesRepository.new
  c.repositories[:quotes]       = SalesCRM::Domain::Repositories::InMemory::QuotesRepository.new
  c.repositories[:activities]   = SalesCRM::Domain::Repositories::InMemory::ActivitiesRepository.new
end

cfg = SalesCRM.configuration

lead_svc  = SalesCRM::Domain::Services::LeadService.new(leads_repo: cfg.repositories[:leads], accounts_repo: cfg.repositories[:accounts], contacts_repo: cfg.repositories[:contacts])
acct_svc  = SalesCRM::Domain::Services::AccountService.new(accounts_repo: cfg.repositories[:accounts])
cont_svc  = SalesCRM::Domain::Services::ContactService.new(contacts_repo: cfg.repositories[:contacts])
prod_svc  = SalesCRM::Domain::Services::ProductService.new(products_repo: cfg.repositories[:products])
quote_svc = SalesCRM::Domain::Services::QuoteService.new(quotes_repo: cfg.repositories[:quotes], products_repo: cfg.repositories[:products], tax_rate: 0.08)
opp_svc   = SalesCRM::Domain::Services::OpportunityService.new(opps_repo: cfg.repositories[:opportunities], quotes_repo: cfg.repositories[:quotes])
act_svc   = SalesCRM::Domain::Services::ActivityService.new(activities_repo: cfg.repositories[:activities])
pipe_svc  = SalesCRM::Domain::Services::PipelineService.new(opps_repo: cfg.repositories[:opportunities])
report_svc= SalesCRM::Domain::Services::ReportService.new(opps_repo: cfg.repositories[:opportunities], leads_repo: cfg.repositories[:leads], quotes_repo: cfg.repositories[:quotes])
email_svc = SalesCRM::Domain::Services::EmailService.new(adapter: cfg.email_adapter)

# --- Seed products ---
prod1 = prod_svc.create_product(sku: 'SUBS-STD', name: 'Standard Subscription', unit_price_cents: 4999)
prod2 = prod_svc.create_product(sku: 'ONB-SETUP', name: 'Onboarding Setup', unit_price_cents: 15000)

# --- Lead → Qualified → Convert ---
lead = lead_svc.create_lead(name: 'Alex Morgan', company: 'Morgan Ventures', email: 'alex@morganv.io', phone: '+1 415 555 1100')
lead = lead_svc.qualify(lead_id: lead.id, rating: 'A')
conversion = lead_svc.convert(lead_id: lead.id)
account = conversion[:account]
contact = conversion[:contact]

# --- Opportunity & Quote ---
opp = opp_svc.create_opportunity(account_id: account.id, name: 'Morgan Ventures - Annual Plan', contact_id: contact.id, stage: :qualification)
quote = quote_svc.create_quote(opportunity_id: opp.id)
quote = quote_svc.add_line(quote_id: quote.id, product_sku: 'SUBS-STD', quantity: 10, discount_percent: 5)
quote = quote_svc.add_line(quote_id: quote.id, product_sku: 'ONB-SETUP', quantity: 1)
quote = quote_svc.send_quote(quote_id: quote.id, to_email: contact.email, email_service: email_svc)

opp = opp_svc.link_quote(opportunity_id: opp.id, quote_id: quote.id)
opp = opp_svc.advance_stage(opportunity_id: opp.id) # -> proposal
opp = opp_svc.advance_stage(opportunity_id: opp.id) # -> negotiation

# Customer accepts
quote = quote_svc.accept_quote(quote_id: quote.id)
opp = opp_svc.set_stage(opportunity_id: opp.id, stage: :closed_won)

# --- Activities ---
call = act_svc.log_activity(type: :call, subject: 'Kickoff call', related_type: 'opportunity', related_id: opp.id, owner_id: 'user_1', content: 'Discuss onboarding timeline')
act_svc.complete(activity_id: call.id)

# --- Reports ---
pipeline = pipe_svc.weighted_pipeline
puts "Pipeline (weighted $):"
pipeline.each do |stage, rec|
  puts "  #{stage}: count=#{rec[:count]}, total=$#{rec[:total_cents]/100.0}, weighted=$#{rec[:weighted_cents]/100.0}"
end

puts "Win rate: #{(report_svc.win_rate*100).round(0)}%"
puts "Avg deal size (won): $#{report_svc.average_deal_size/100.0}"
puts "Quote conversion rate: #{(report_svc.quote_conversion_rate*100).round(0)}%"

puts "
Done."
