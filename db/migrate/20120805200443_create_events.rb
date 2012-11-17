class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string :user
      t.string :name
      t.date :date
    end
  end

  def down
    drop_table :events
  end
end
