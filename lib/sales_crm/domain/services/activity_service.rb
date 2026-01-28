# frozen_string_literal: true

module SalesCRM
  module Domain
    module Services
      class ActivityService
        def initialize(activities_repo:, logger: SalesCRM.logger)
          @activities = activities_repo
          @logger = logger
        end

        def log_activity(type:, subject:, related_type:, related_id:, owner_id:, due_at: nil, content: nil)
          a = Entities::Activity.new(id: Utils::UUID.v4, type: type, subject: subject, related_type: related_type, related_id: related_id, owner_id: owner_id, due_at: due_at, content: content)
          @activities.create(a)
          a
        end

        def complete(activity_id:)
          a = @activities.find(activity_id)
          raise SalesCRM::NotFound, 'activity not found' unless a
          a.status = 'completed'
          a.completed_at = Time.now
          @activities.update(a)
          a
        end

        def timeline(related_type:, related_id:)
          @activities.for_related(related_type, related_id).sort_by(&:created_at)
        end
      end
    end
  end
end
