class CreateEventTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :event_topics do |t|
      t.references :event, foreign_key: true
      t.references :topic, foreign_key: true

      t.timestamps
    end
  end
end
