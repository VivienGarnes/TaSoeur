class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.string :description

      t.timestamps
    end

		add_pins :questions, :up_votes, :integer, :null => false, :default => 0
		add_pins :questions, :down_votes, :integer, :null => false, :default => 0

  end
end
