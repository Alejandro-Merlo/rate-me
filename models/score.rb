class Score < ActiveRecord::Base

#  self.abstract_class = true

  validates_presence_of :qualification
  validates_presence_of :comment
  
end
