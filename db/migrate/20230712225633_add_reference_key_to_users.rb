class AddReferenceKeyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reference_key, :integer
  end
end
