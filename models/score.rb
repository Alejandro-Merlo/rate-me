class Score < ActiveRecord::Base
  validates_presence_of :qualification
  validates_presence_of :comment
  
end
