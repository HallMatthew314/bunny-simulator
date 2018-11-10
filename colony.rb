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

		puts "Press enter for next year"
		gets
	end
end