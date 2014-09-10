class Grid

  attr_accessor :ships

  def initialize
    @ships = []
  end

  def add_ship(ship)
    raise 'Nil ship error' if ship.nil?
    conflicts = @ships.inject([]){|conflicted, _ship| conflicted += (_ship.squares & ship.squares) }
    raise ArgumentError.new("Ship space conflict: #{conflicts.inspect}") unless conflicts.length == 0
    @ships << ship
    ship
  end

  def live_ships
    @ships.select{|ship| !ship.dead? }
  end

  def is_hit?(x, y)
    @ships.any?{|ship| ship.is_hit?(x,y) }
  end

  # returns true if any ships hit (and loc not already hit)
  def fire(x,y)
    @ships.any?{ |ship| ship.fire(x,y) }
  end

  def win?
    @ships.all?{|ship| ship.dead? }
  end

  def squares
    @ships.inject([]){|squares, ship| squares += ship.squares }
  end

  def hits
    @ships.inject([]){|squares, ship| squares += ship.hits }
  end

end