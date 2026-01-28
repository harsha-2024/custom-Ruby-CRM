# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class QuoteService
        def initialize(quotes_repo:, products_repo:, tax_rate: 0.0, logger: SalesCRM.logger)
          @quotes = quotes_repo
          @products = products_repo
          @tax_rate = tax_rate
          @logger = logger
        end

        def create_quote(opportunity_id:, currency: 'USD')
          q = Entities::Quote.new(id: Utils::UUID.v4, opportunity_id: opportunity_id, currency: currency)
          @quotes.create(q)
          q
        end

        def add_line(quote_id:, product_sku:, quantity:, discount_percent: 0)
          q = fetch(quote_id)
          product = @products.find_by_sku(product_sku)
          raise SalesCRM::NotFound, 'product not found' unless product
          q.lines << Entities::Quote::Line.new(product_id: product.id, sku: product.sku, name: product.name, quantity: quantity, unit_price_cents: product.unit_price_cents, discount_percent: discount_percent)
          recalc(q)
          @quotes.update(q)
          q
        end

        def send_quote(quote_id:, to_email:, email_service: nil)
          q = fetch(quote_id)
          q.status = :sent
          @quotes.update(q)
          body = "Quote ##{q.id}
Total: $#{q.total_cents/100.0}
Thank you for your business!"
          (email_service || SalesCRM::Domain::Services::EmailService.new(adapter: SalesCRM.configuration.email_adapter)).send(to: to_email, subject: "Your Quote #{q.id}", body: body)
          @logger.info("quote: sent #{q.id} to #{to_email}")
          q
        end

        def accept_quote(quote_id:)
          q = fetch(quote_id)
          q.status = :accepted
          @quotes.update(q)
          q
        end

        def reject_quote(quote_id:)
          q = fetch(quote_id)
          q.status = :rejected
          @quotes.update(q)
          q
        end

        private
        def fetch(id)
          q = @quotes.find(id)
          raise SalesCRM::NotFound, 'quote not found' unless q
          q
        end

        def recalc(q)
          subtotal = q.lines.sum do |l|
            price = l.unit_price_cents * l.quantity
            discount = (price * (l.discount_percent.to_f / 100)).round
            price - discount
          end
          tax = (subtotal * @tax_rate).round
          q.subtotal_cents = subtotal
          q.discount_cents = q.lines.sum { |l| (l.unit_price_cents * l.quantity * (l.discount_percent.to_f / 100)).round }
          q.tax_cents = tax
          q.total_cents = subtotal + tax
        end
      end
    end
  end
end
