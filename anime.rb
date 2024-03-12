class AnimeObject
  private
  attr_reader :start_date
  attr_reader :end_date
  attr_reader :rating

  public
  def initialize(start_date, end_date, rating)
    @start_date = start_date
    @end_date = end_date
    @rating = rating
  end
  
  def get_rating()
    return @rating
  end

  def get_start_date()
    return @start_date
  end

  def get_end_date()
    return @end_date
  end
end
