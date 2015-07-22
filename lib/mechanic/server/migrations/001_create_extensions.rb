class CreateExtensions < ActiveRecord::Migration
	def self.up
		create_table :extensions do |t|
			t.string :name
			t.string :repository
			t.string :filename
			t.string :description
			t.string :author

			t.timestamps null: false
		end
	end

	def self.down
		drop_table :extensions
	end
end
