class Bunny
	
	attr_accessor :name, :age, :sex, :colour, :rmvb

	def initialize(*args)
		@age = 0
		@sex = rand(2) # 1 or 0, male or female
		@colour = rand(4) # 0..3, corresponds to a constant in colour.rb
		@rmvb = rand(50) == 0 # @rmvb is true 2% of the time upon creation
		namelist = @sex == 0 ? 'names_female.txt' : 'names_male.txt' # Pick name pool based on this bunny's sex
		@name = File.readlines(namelist)[rand(50)].strip # Pick a name from the name pool and strip whitespace
	end

	def to_s
		# All instance variables separated by tabs
		format("%s\t%s\t%s\t%s\t%s", @name, @age, @sex, @colour, @rmvb)
	end
end