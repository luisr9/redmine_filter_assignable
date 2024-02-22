require_dependency 'issue'

module RedmineFilterAssignable
  module Issues
    module Patches
      module IssueControllerPatch
        def self.included(base)
          base.class_eval do
            alias_method :assignable_users_without_filter, :assignable_users
            alias_method :assignable_users, :assignable_users_with_filter_assignable
          end
        end
        
        def assignable_users_with_filter_assignable
          types = nil
          if Setting.plugin_redmine_filter_assignable['filtera_users'] == "true" && Setting.plugin_redmine_filter_assignable['filtera_groups'] == "true"
            types = ['User', 'Group']
          elsif Setting.plugin_redmine_filter_assignable['filtera_users'] == "true"
            types = ['User']
          elsif Setting.plugin_redmine_filter_assignable['filtera_groups'] == "true"
            types = ['Group']
          end

          if types.nil?
            users = []
            users << author if author && author.active? && Setting.plugin_redmine_filter_assignable['filtera_autor'] == "true"
            users << assigned_to if assigned_to
            users.uniq.sort
          else
            users = project.assignable_users.where(type: types).where("role_id IN (?)",
              WorkflowTransition.where(tracker_id: tracker_id, old_status_id: status_id).select(:role_id).distinct.map(&:role_id)
            ).to_a
            users << author if author && author.active? && Setting.plugin_redmine_filter_assignable['filtera_autor'] == "true"
            users << assigned_to if assigned_to
            users.uniq.sort
          end
        end
      end
    end
  end
end

IssueController.prepend RedmineFilterAssignable::Issues::Patches::IssueControllerPatch
