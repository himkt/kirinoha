class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :code
      t.string :title
      t.float :credits
      t.string :grades
      t.string :terms
      t.string :daytimes
      t.string :location
      t.string :instructors
      t.text :info
      t.boolean :ca
      t.text :condition
      t.string :alternative

      t.timestamps null: false
    end
  end
end
