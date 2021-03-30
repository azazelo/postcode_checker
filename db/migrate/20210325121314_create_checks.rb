# frozen_string_literal: true

class CreateChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :checks do |t|
      t.string :value
      t.timestamps
    end
  end
end
