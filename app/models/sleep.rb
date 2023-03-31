class Sleep < ApplicationRecord
  belongs_to :user, touch: true
end
