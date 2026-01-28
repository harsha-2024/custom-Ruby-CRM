# frozen_string_literal: true

module SalesCRM
  module Domain
    module Entities
      class Activity
        attr_accessor :id, :type, :subject, :status, :due_at, :content, :related_type, :related_id, :owner_id, :created_at, :completed_at
        def initialize(id:, type:, subject:, related_type:, related_id:, owner_id:, status: 'open', due_at: nil, content: nil, created_at: Time.now, completed_at: nil)
          @id = id
          @type = type
          @subject = subject
          @status = status
          @due_at = due_at
          @content = content
          @related_type = related_type
          @related_id = related_id
          @owner_id = owner_id
          @created_at = created_at
          @completed_at = completed_at
        end
      end
    end
  end
end
