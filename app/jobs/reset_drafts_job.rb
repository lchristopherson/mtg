class ResetDraftsJob < ApplicationJob
  queue_as :default

  def perform
    # Delete Drafters
    Drafter.all.map { |d| d.update(left: nil, right: nil); d }.each { |d| d.delete }

    Pack.all.map(&:delete)

    Draft.all.map(&:delete)
  end
end
