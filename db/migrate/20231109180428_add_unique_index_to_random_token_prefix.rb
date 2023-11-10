class AddUniqueIndexToRandomTokenPrefix < ActiveRecord::Migration[7.1]
  def change
    add_index :api_keys, [:random_token_prefix, :bearer_id, :bearer_type], unique: true
  end
end
