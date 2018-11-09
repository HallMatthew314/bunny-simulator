class Colony
	
	attr_accessor :bunnies, :year

	def initialize()
		@year = 0
		@bunnies = []
		5.times do @bunnies.push(Bunny.new) end
	end
end