class DeleteColumnCode < ActiveRecord::Migration[7.0]
  def change
    remove_column :teams, :code
  end
end
