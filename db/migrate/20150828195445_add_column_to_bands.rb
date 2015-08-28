class AddColumnToBands < ActiveRecord::Migration
  def change
    add_column(:bands, :done, :boolean)
  end
end
