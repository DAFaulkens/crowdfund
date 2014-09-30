class MakePledgesAJoinTable < ActiveRecord::Migration

  def up
    Pledge.delete_all
    remove_column :pledges, :name
    remove_column :pledges, :email
    add_column :pledges, :user_id, :integer
  end

  def down
    Pledge.delete_all
    remove_column :pledges, :user_id
    add_column :pledges, :email, :string
    add_column :pledges, :name, :string
  end
end
