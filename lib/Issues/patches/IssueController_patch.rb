require_dependency 'issue'

class Issue
  
  def assignable_users_with_filter_assignable
    users = project.assignable_users.where("role_id IN (?)",
    WorkflowTransition.where(:tracker_id => tracker_id, :old_status_id => status_id).select(:role_id).distinct.map { |e| e.role_id }
    ).to_a
    users << author if author && author.active?
    users << assigned_to if assigned_to
    users.uniq.sort
  end

  alias_method_chain :assignable_users, :filter_assignable
end

