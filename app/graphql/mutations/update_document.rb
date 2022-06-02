module Mutations
  class UpdateDocument < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :knowledge_base_id, ID, required: false
    argument :content, String, required: false

    field :document, Types::DocumentType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      document = Document.find_by(id: input.delete(:id))

      document.update(input)
      new_contributor = Document::Contributor.new(id: current_account.id)
      unless document.contributors.include?(new_contributor)
        document.contributors << new_contributor
      end

      if document.save && document.errors.blank?
        {document: document}
      else
        {errors: Types::Base::ModelError.errors_of(document)}
      end
    end
  end
end
