# frozen_string_literal: true

class CreateSearchFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :search_filters do |t|
      t.references :user, foreign_key: true
      t.references :city, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.references :topic, foreign_key: true

      t.timestamps
    end
  end
end
