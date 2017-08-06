class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #binding.pry
    self.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.joins(boats: :classifications).group(:captain_id).where(classifications: {name: "Sailboat"})
  end

  def self.talented_seamen
    m = self.joins(boats: :classifications).group(:captain_id).where(classifications: {name: "Motorboat"})
    self.where(id: (self.sailors & m))
  end

  def self.non_sailors
    ids = self.sailors.select(:id)
    self.where.not(id: ids)
    #self.all - self.sailors
    #this will only return an array
  end
end
