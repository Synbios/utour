class CreateSaleAgents < ActiveRecord::Migration
  def change
    create_table :sale_agents do |t|
      t.integer :sale_id
      t.integer :agent_id

      t.timestamps
    end
  end
end
