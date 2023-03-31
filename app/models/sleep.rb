class Sleep < ApplicationRecord
  belongs_to :user, touch: true

  def clocked_in
    self.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def clocked_out
    self.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end

end
