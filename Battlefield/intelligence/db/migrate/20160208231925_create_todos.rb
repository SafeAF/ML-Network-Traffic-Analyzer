class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.string :desc
      t.datetime :eta
      t.references :project, index: true, foreign_key: true
      t.references :department, index: true, foreign_key: true
      t.references :infrastructure, index: true, foreign_key: true
      t.references :operations, index: true, foreign_key: true
      t.references :username, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true
      t.integer :estimated_manhours
      t.integer :total_manhours
      t.float :ratio_actual_manhours
      t.text :details
      t.references :tasklist, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :priority

      t.timestamps null: false
    end
  end
end
