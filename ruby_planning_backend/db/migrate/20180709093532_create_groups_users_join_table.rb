class CreateGroupsUsersJoinTable < ActiveRecord::Migration[5.1]
  def change
    # This is enough; you don't need to worry about order
    create_join_table :groups, :users

    # If you want to add an index for faster querying through this join:
    create_join_table :groups, :users do |t|
      t.index :group_id
      t.index :user_id
    end
  end
end
