class Venue < ActiveRecord::Base
  has_and_belongs_to_many(:bands)

  validates(:title, :presence => true)
scope(:not_done, -> do
  where({:done => false})
end)
end
