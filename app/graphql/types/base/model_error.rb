module Types
    module Base
      class ModelError < Types::Base::Object
        description "ActiveModel::Errors"
  
        field :message, String, null: false
        field :path, [String], null: true
  
        class << self
          def errors_of(model)
            model.errors.collect do |attribute, message|
              format(attribute, message)
            end
          end
  
          def format(attribute, message)
            {
              path: [attribute],
              message: message
            }
          end
        end
      end
    end
  end
  