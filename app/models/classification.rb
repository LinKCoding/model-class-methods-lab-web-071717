class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    #tentative : self.joins(:boats).order("boats.length DESC").limit(2)
    max_length = self.joins(:boats).maximum('boats.length')
    self.joins(:boats).where(boats: {length: max_length})
  end
end
