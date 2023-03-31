class Sleep < ApplicationRecord
  belongs_to :user, touch: true

  def clocked_in
    self.created_at
  end

  def clocked_out
    self.updated_at
  end

end
