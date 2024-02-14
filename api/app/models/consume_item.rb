class ConsumeItem < ApplicationRecord
  belongs_to :itemable, polymorphic: true, optional: true
end
