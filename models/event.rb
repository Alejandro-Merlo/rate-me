class Event < ActiveRecord::Base

#  self.abstract_class = true

  validates_presence_of :username
  validates_presence_of :name
  validates_presence_of :date
  has_many              :scores
  
end
