# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'sales_crm'
  spec.version       = File.read(File.expand_path('lib/sales_crm/version.rb', __dir__)).match(/VERSION\s*=\s*'([^']+)'/)[1]
  spec.authors       = ['Your Name']
  spec.email         = ['you@example.com']

  spec.summary       = 'Custom CRM with end-to-end sales operations.'
  spec.description   = 'Lead → Account/Contact conversion, Products, Quotes, Opportunities, Activities, and Pipeline.'
  spec.license       = 'MIT'

  spec.files = Dir['lib/**/*', 'README.md', 'LICENSE']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.0'
  spec.add_development_dependency 'bundler', '>= 2.3'
end
