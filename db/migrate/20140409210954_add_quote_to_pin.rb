class AddQuoteToPin < ActiveRecord::Migration
  def change
  	change_table :pins do |t|
      t.attachment :quote
    end
  end
end
