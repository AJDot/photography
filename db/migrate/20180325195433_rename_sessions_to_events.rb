class RenameSessionsToEvents < ActiveRecord::Migration[5.1]
  def change
    rename_table :sessions, :events
  end
end
