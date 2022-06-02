class Board < ApplicationRecord
  belongs_to :project
  after_create :init_columns
  class Column
    include StoreModel::Model

    attribute :name, :string
    attribute :description, :string
  end

  attribute :columns, Column.to_array_type

  def init_columns
    project.workflow_steps.each do |step|
      columns << {name: step.name, description: step.description}
    end
  end
end
