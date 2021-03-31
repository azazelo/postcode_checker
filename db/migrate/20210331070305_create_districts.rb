# frozen_string_literal: true

# Create table to keep allowed districts
#
class CreateDistricts < ActiveRecord::Migration[6.1]
  def change
    create_table :districts do |t|
      t.string :name

      t.timestamps
    end
  end
end
