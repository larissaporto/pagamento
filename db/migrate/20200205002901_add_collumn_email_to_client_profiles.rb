class AddCollumnEmailToClientProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :client_profiles, :email, :string
  end
end
