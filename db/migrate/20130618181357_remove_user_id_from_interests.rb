class RemoveUserIdFromInterests < ActiveRecord::Migration
  def up
    remove_column :interests, :user_id
  end

  def down
    add_column :interests, :user_id, :integer
  end
end
