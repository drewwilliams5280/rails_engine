class RemoveCustomerIdFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :customer_id
  end
end
