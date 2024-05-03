class DropApiKeysTable < ActiveRecord::Migration[7.1]
  def change
    remove_index :api_keys, name: "index_api_keys_on_bearer"
    remove_index :api_keys, name: "index_api_keys_on_token_digest"
    drop_table :api_keys
  end
end
