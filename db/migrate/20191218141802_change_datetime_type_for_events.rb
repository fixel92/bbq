class ChangeDatetimeTypeForEvents < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :datetime, :datetime
  end
end
