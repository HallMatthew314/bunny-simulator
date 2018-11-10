class Colony
  
  attr_accessor :bunnies, :year

  def initialize()
    @year = 0

    next_year() until @year > 0 && @bunnies.empty?
  end

  def next_year()
    @year += 1
    EventLogger.announce_year_start(@year)

    # Create five bunnies for the first year
    @bunnies = Array.new(5) { Bunny.new } if year == 1

    # Each bunny grows one year older
    @bunnies.each { |b| b.grow_older }

    # Every RMVB infects excatly 1 regular bunny
    infect_population if count_rmvb > 0

    # If a bunny is too old, they die of old age
    @bunnies.each { |b| b.announce_death if b.too_old? }
    # This is split into two lines because deleting with .each misses some array entries
    @bunnies.delete_if { |b| b.too_old? }

    # Prompt to press enter to either quit or simulate next year
    puts @bunnies.empty? ? "There are no more bunnies. Press enter to quit..." : "Press enter to simulate next year..."
    gets
  end

  def count_rmvb
    @bunnies.select { |b| b.rmvb }.length
  end

  def count_non_rmvb
    @bunnies.reject { |b| b.rmvb }.length
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
end