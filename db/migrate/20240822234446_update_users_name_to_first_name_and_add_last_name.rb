class UpdateUsersNameToFirstNameAndAddLastName < ActiveRecord::Migration[6.1]
  def change
     # Rename 'name' column to 'first_name'
    rename_column :users, :name, :first_name

    # Add 'last_name' column
    add_column :users, :last_name, :string
  end
end
