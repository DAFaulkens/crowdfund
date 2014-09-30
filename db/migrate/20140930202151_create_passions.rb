class CreatePassions < ActiveRecord::Migration
  def change
    create_table :passions do |t|
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
