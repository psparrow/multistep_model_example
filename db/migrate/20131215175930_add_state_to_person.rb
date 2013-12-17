class AddStateToPerson < ActiveRecord::Migration
  def change
    add_column :people, :state, :string
  end
end
