class Colony
	
	attr_accessor :bunnies, :year

	def initialize()
		@year = 0
		@bunnies = Array.new(5) { Bunny.new }

		#test
		EventLogger.announce_year_start(@year)
	end
end