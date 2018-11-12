class Colony
  
  attr_accessor :bunnies, :year

  def initialize
    @year = 0

    next_year() until @year > 0 && @bunnies.empty?
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
    mature_females.each { |m| @bunnies.push(Bunny.new(colour: m.colour)) }

    # If a bunny is too old, they die of old age
    @bunnies.each { |b| b.announce_death if b.too_old? }
    # This is split into two lines because deleting with .each misses some array entries
    @bunnies.delete_if { |b| b.too_old? }

    # Show status of the colony
    print_colony_summary

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
    # Used as argument for rand()
    infection_chance = @bunnies.length - count_rmvb
    bunnies_to_infect = count_rmvb

    until count_non_rmvb == 0 || bunnies_to_infect == 0 do
      @bunnies.each do |b|
        break if count_non_rmvb == 0 || bunnies_to_infect == 0
        if !b.rmvb && rand(infection_chance) == 0 then
          b.infect
          bunnies_to_infect -= 1
        end
      end
    end
  end

  def bunnies_to_be_born
    # REVIEW: This should work as a ternary statement, but the line is very long. Break into multiple lines?
    # If there is at least one elligible male, return the number of elligible females. Otherwise, return 0.
    @bunnies.any? { |b| !b.rmvb && b.sex == Sex::MALE && b.age >= 2 } ? @bunnies.select { |b| !b.rmvb && b.sex == Sex::FEMALE && b.age >= 2 }.length : 0
  end

  def print_colony_summary
    puts 'Colony Summary:' unless @bunnies.empty?
    @bunnies.each { |b| puts b.to_s }
  end
end