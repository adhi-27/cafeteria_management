class SpecificMenuItem < ApplicationRecord
  belongs_to :menus, optional: true
end
