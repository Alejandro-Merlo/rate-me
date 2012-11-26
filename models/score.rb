class Score < ActiveRecord::Base
  validates_presence_of :qualification
                        :comment
  
end
