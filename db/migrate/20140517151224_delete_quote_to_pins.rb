class DeleteQuoteToPins < ActiveRecord::Migration
  def change
    remove_columns :pins, :quote_file_name
    remove_columns :pins, :quote_content_type
    remove_columns :pins, :quote_file_size
    remove_columns :pins, :quote_updated_at
  end
end
