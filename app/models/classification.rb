class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # return all classifications
    all
  end

  def self.longest
    # return classifications for the longest boat by using boat#longest
    Boat.longest.classifications
  end

end
