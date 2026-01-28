# SalesCRM

A modular Ruby CRM library that implements **end‑to‑end sales operations**: lead management, account & contact management, products & price books, quotes, opportunities & pipeline, activities (tasks/calls/emails/meetings), simple forecasting, and email sending via pluggable adapters. Ships with in‑memory repositories and a test email adapter so you can run it immediately.

## Highlights
- **Leads** → qualify/convert to **Accounts** + **Contacts**
- **Opportunities** with stages & probability (Prospecting → Qualification → Proposal → Negotiation → Closed Won/Lost)
- **Quotes** with lines, discounts, tax, totals; send quote (email adapter mock)
- **Activities** (task/call/email/meeting) with completion and timeline
- **Products** with simple pricing
- **Pipeline & Forecasting** (weighted revenue per stage)
- **Pluggable Adapters**: Email adapter interface with an in‑memory test implementation
- **Repositories**: In‑memory out of the box; swap for ActiveRecord/Sequel by following the same interface

## Quickstart
```bash
bundle install
bundle exec ruby examples/end_to_end.rb
```

## Install as a Gem
```ruby
# Gemfile
gem 'sales_crm', path: '/path/to/sales_crm'
```

```bash
bundle install
```

## Configuration
```ruby
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
```

## Status
This is a functional reference implementation intended to be extended for production. Add persistence, background jobs, authentication, auditing, and real email providers.
