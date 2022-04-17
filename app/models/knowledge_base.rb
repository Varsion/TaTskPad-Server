class KnowledgeBase < ApplicationRecord
  belongs_to :project
  has_many :documents, dependent: :destroy

  def archive!
    update(archived: true)
    documents.each do |document|
      document.archive!
    end
  end
end
