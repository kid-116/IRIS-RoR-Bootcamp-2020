class AddLimitColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :private_articles_remaining, :integer
  end
end
