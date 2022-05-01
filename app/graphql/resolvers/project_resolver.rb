module Resolvers
  class ProjectResolver < BaseResolver
    type Types::ProjectType, null: true

    argument :project_id, ID, required: true
    def resolve(project_id:)
      authenticate_user!
      project = Project.find_by(id: project_id)
      return nil if project.nil?
      project.organization.is_member?(current_account) ? project : nil
    end
  end
end
