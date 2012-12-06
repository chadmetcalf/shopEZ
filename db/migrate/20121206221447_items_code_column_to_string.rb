class ItemsCodeColumnToString < ActiveRecord::Migration
  def up
    change_column :items, :code, :string
  end

  def down
    change_column :items, :code, :integer
  end
end