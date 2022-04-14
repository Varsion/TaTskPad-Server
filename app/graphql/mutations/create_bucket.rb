module Mutations
  class CreateBucket < Mutations::BaseMutation
    argument :project_id, ID, required: true
    argument :name, String, required: true

    field :bucket, Types::BucketType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      project = Project.find_by(id: input[:project_id])

      raise GraphQL::ExecutionError, "no premiss" unless project.organization.is_member?(current_account)

      bucket = Bucket.new(input)

      if bucket.save && bucket.errors.blank?
        {
          bucket: bucket
        }
      else
        {
          errors: Types::Base::ModelError.errors_of(bucket)
        }
      end
    end
  end
end
