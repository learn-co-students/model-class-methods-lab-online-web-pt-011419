class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # return all catamaran captains by finding boats that include a
    # classification where the classification is catamaran
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    # return all unique sailors by finding boats that include a
    # classification where the classification is sailboat
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    # return all motorboat operators by finding boats that include a
    # classification where the classification is motorboat
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    # return all talented seafarers by finding those who have both a sailor id
    # and a motorboat operator id
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    # return all non-sailors by finding those who don't have a sailor id
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
