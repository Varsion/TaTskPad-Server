class KnowledgeBase < ApplicationRecord
  belongs_to :project

  def archive!
    update(archived: true)
  end
end
