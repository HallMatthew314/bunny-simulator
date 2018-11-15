class Bunny
  
  attr_accessor :name, :age, :sex, :colour, :rmvb

  def initialize(colour: 'random')
    @age = 0
    @sex = Sex.pick_random
    @colour = colour # If colour is not specified (as int), randomly select one on the next line
    @colour = Colour.pick_random if @colour == 'random' # 0..3, corresponds to a constant in colour.rb
    @rmvb = rand(50) == 0 # @rmvb is true 2% of the time upon creation
    namelist = @sex == 0 ? 'names_female.txt' : 'names_male.txt' # Pick name pool based on this bunny's sex
    @name = File.readlines(namelist)[rand(50)].strip # Pick a name from the name pool and strip whitespace

    EventLogger.announce_birth(@name, @rmvb)
  end

  def announce_death(cause: CauseOfDeath::OLD_AGE)
    EventLogger.announce_death(@name, @rmvb, @age, cause: cause)
  end

  def grow_older
    @age += 1
    EventLogger.announce_older(@name, @rmvb, @age)
  end

  def infect
  	@rmvb = true
  	EventLogger.announce_infection(@name)
  end

  def too_old?
    # A bunny cannot be more than ten years old, an RMVB cannot be more than 50 years old
    @rmvb ? @age > 50 : @age > 10
  end

  def to_s
    # Convert @rmvb Bool to String
    s_rmvb = @rmvb ? 'RMVB' : 'Not RMVB'

    # All instance variables separated by tabs
    format("%s\t%s\t%s\t%s\t%s", @name, @age, Sex.value_to_string(@sex), Colour.value_to_string(@colour), s_rmvb)
  end
end