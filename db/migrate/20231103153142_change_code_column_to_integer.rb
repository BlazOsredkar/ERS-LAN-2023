class ChangeCodeColumnToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :teams, :code, :integer
  end
end
