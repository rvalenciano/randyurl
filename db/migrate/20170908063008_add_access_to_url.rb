# frozen_string_literal: true

class AddAccessToUrl < ActiveRecord::Migration[5.1]
  def change
    add_column :urls, :access, :int, default: 0
  end
end
