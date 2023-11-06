class CreateApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.belongs_to :bearer, polymorphic: true
      t.string :name, null: false
      t.string :common_token_prefix, null: false
      t.string :random_token_prefix, null: false
      t.string :token_digest, null: false
      t.timestamp :revoked_at

      t.timestamps
    end

    add_index :api_keys, :token_digest, unique: true
  end
end
