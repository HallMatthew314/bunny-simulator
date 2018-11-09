class Bunny
	
	attr_accessor :name, :age, :sex, :colour, :rmvb

	def initialize(*args)
		@age = 0
		@sex = rand(2) # 1 or 0, male or female
		@colour = rand(4) # 0..3, corresponds to a constant in colour.rb
		@name = "Name Machine Broke" # TODO: Create a pool of names to randomly select from
		@rmvb = rand(50) == 0 # @rmvb is true 2% of the time upon creation
	end

	def to_s
		# All instance variables separated by tabs
		format("%s\t%s\t%s\t%s\t%s", @name, @age, @sex, @colour, @rmvb)
	end
end