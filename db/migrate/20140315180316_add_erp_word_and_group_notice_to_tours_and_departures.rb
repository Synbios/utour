class AddErpWordAndGroupNoticeToToursAndDepartures < ActiveRecord::Migration
  def change
    add_column :tours, :erp_word_url, :string
    add_column :departures, :erp_group_notice_url, :string
  end
end
