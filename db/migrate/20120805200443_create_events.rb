class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string :username
      t.string :name
      t.date :date
      t.references :user
    end
  end

  def down
    drop_table :events
  end
end
