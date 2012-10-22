class CreateScores < ActiveRecord::Migration
  def up
    create_table :scores do |t|
      t.string :qualification
      t.string :comment
      t.references :event
    end
  end

  def down
    drop_table :scores
  end
end
