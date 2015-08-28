class AddBooleanToValues < ActiveRecord::Migration
  def change
    add_column(:venues, :done, :boolean)
  end
end
