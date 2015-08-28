class Band < ActiveRecord::Base
  has_and_belongs_to_many(:venues)

  validates(:name, :presence => true)
scope(:not_done, -> do
  where({:done => false})
end)
end
