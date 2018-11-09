class Bunny
	
	attr_accessor :name, :age, :sex, :colour, :rmvb

	def initialize(*args)
		@age = 0
		@sex = rand(2) # 1 or 0, male or female
		@colour = rand(4) # 0..3, corresponds to a constant in colour.rb
		@rmvb = rand(50) == 0 # @rmvb is true 2% of the time upon creation
		namelist = @sex == 0 ? 'names_female.txt' : 'names_male.txt' # Pick name pool based on this bunny's sex
		@name = File.readlines(namelist)[rand(50)].strip # Pick a name from the name pool and strip whitespace

		EventLogger.announce_birth(@name, @rmvb)
	end

	def to_s
		# Convert @sex Integer to String
		s_sex = @sex == 0 ? "Female" : "Male"

		# Convert @colour Integer to String
		s_colour = case @colour
			when 0 then "White"
			when 1 then "Brown"
			when 2 then "Black"
			when 3 then "Spotted"
			end	

		# Convert @rmvb Bool to String
		s_rmvb = @rmvb ? "RMVB" : "Not RMVB"

		# All instance variables separated by tabs
		format("%s\t%s\t%s\t%s\t%s", @name, @age, s_sex, s_colour, s_rmvb)
	end
end