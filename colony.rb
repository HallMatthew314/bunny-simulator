class Colony
  
  attr_accessor :bunnies, :year

  def initialize
    @year = 0

    next_year until @year > 0 && @bunnies.empty?
  end

  def next_year
    @year += 1
    EventLogger.announce_year_start(@year)

    # Create five bunnies for the first year
    @bunnies = Array.new(5) { Bunny.new } if year == 1

    # Each bunny grows one year older
    @bunnies.each { |b| b.grow_older }

    # Every RMVB infects excatly 1 regular bunny
    infect_population if count_rmvb > 0

    # Every mature female has a baby (if possible)
    # Offspring are given the same colour as their mother
    mature_females.each { |m| @bunnies.push(Bunny.new(colour: m.colour)) } if able_to_multiply?

    # If a bunny is too old, they die of old age
    @bunnies.each { |b| b.announce_death(cause: CauseOfDeath::OLD_AGE) if b.too_old? }
    # This is split into two lines because deleting with .each misses some array entries
    @bunnies.delete_if { |b| b.too_old? }

    # If the colony is overpopulated, a food shortage occurs, killing exactly half of the bunnies
    famine if overpopulated?

    # Show status of the colony
    print_colony_summary unless @bunnies.empty?

    # Prompt to press enter to either quit or simulate next year
    puts @bunnies.empty? ? 'There are no more bunnies. Press enter to quit...' : 'Press enter to simulate next year...'
    gets
  end

  def count_rmvb
    @bunnies.select { |b| b.rmvb }.length
  end

  def count_non_rmvb
    @bunnies.reject { |b| b.rmvb }.length
  end

  def mature_females
    @bunnies.select { |b| !b.rmvb && b.sex == Sex::FEMALE && b.age >= 2 }
  end

  def infect_population
    # Get list of indexes of uninfected bunnies
    bunnies_to_infect = []
    @bunnies.each_with_index { |b,i| bunnies_to_infect.push(i) if !b.rmvb }

    # Randomly infect the population
    bunnies_to_infect.shuffle.first(count_rmvb).sort.each { |i| @bunnies[i].infect }
  end

  def able_to_multiply?
    @bunnies.any? { |b| !b.rmvb && b.sex == Sex::MALE && b.age >= 2 } && mature_females.length > 0
  end

  def print_colony_summary
    puts 'Colony Summary:'
    puts format("Population size: %s", @bunnies.length)
    puts format("Male to Female ratio: %.2f", @bunnies.select { |b| b.sex == Sex::MALE }.length.to_f / @bunnies.select { |b| b.sex == Sex::FEMALE }.length.to_f)
    puts format("Percentage of population RMVB: %.1f%%", 100 * count_rmvb.to_f / @bunnies.length.to_f)
  end

  def famine
    EventLogger.announce_famine(@bunnies.length)
    
    indexes = (0..@bunnies.length-1).to_a
    half = @bunnies.length/2

    marked_for_death = indexes.shuffle.first(half)
    marked_for_death.each { |i| @bunnies[i].announce_death(cause: CauseOfDeath::FAMINE) }
    marked_for_death.reverse_each { |i| @bunnies.delete_at(i) }
  end

  def overpopulated?
    @bunnies.length > 1000
  end
end