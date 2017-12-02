class Entry < ApplicationRecord
  belongs_to :user

  def self.on_date(date)
    where("DATE(entry_date) = ?", date)
  end
end
