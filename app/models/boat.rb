class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    all[0..4]
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    all.sort_by { |boat| boat.name }.last(3).reverse
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  # def self.longest
  #   order('length DESC').first
  # end
end
