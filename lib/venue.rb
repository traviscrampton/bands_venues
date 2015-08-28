class Venue < ActiveRecord::Base
  has_and_belongs_to_many(:bands)
  validates(:title, :presence => true)
  before_save(:capitalize_title)
scope(:not_done, -> do
  where({:done => false})
end)

private
  define_method(:capitalize_title) do
    self.title = title().capitalize()
  end
end
