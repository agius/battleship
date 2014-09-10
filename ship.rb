class Ship

  attr_accessor :x, :y, :orientation, :length, :squares, :hits

  def initialize(x, y, orientation, length)
    @x, @y, @orientation, @length = [x, y, orientation, length]
    raise ArgumentError.new("orientation must be :vertical or :horizontal") unless [:horizontal, :vertical].include?(orientation)
    raise ArgumentError.new("x must be between 1 and 10 (inclusive") unless @x >= 1 && @x <= 10
    raise ArgumentError.new("y must be between 1 and 10 (inclusive") unless @y >= 1 && @y <= 10
    raise ArgumentError.new("length must be between 2 and 5 (inclusive") unless @length >= 2 && @length <= 5
    if @orientation == :horizontal
      @squares = (@x..(@x + (@length - 1))).to_a.collect{|_x| [_x, @y] }
    else
      @squares = (@y..(@y + (@length - 1))).to_a.collect{|_y| [@x, _y] }
    end
    @hits = []
    self
  end

  def is_hit?(x,y)
    return true if @squares.any?{|loc| loc == [x,y] }
    false
  end

  def fire(x,y)
    is_hit = is_hit?(x,y) && !@hits.include?([x,y])
    @hits << [x,y] if is_hit
    is_hit
  end

  def dead?
    @squares == @hits
  end


end