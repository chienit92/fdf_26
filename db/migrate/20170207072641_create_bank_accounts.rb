class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
      t.string :serial
      t.float :blance

      t.timestamps
    end
  end
end
