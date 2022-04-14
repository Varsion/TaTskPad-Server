module Mutations
  class UpdateBucket < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: true

    field :bucket, Types::BucketType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      bucket = Bucket.find_by(id: input[:id])
      return { errors: [{ path: [], message: "Bucket not found" }] } unless bucket

      organization = bucket.project.organization

      raise GraphQL::ExecutionError, "no premiss" unless organization.is_member?(current_account)

      bucket.update(name: input[:name])

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
