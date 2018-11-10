class EventLogger
	
	def self.announce_year_start(year)
		puts format("-- START OF YEAR %s --", year)
	end

	def self.announce_birth(name, rmvb)
		# Refer to a bunny as either 'Bunny' or 'Radioactive Mutant Vampire Bunny'
		puts format("%sBunny %s was born!", (rmvb == true ? "Radioactive Mutant Vampire " : ""), name)
	end

	def self.announce_older(name, rmvb, age)
		puts format("%sBunny %s is now %s year%s old", (rmvb == true ? "Radioactive Mutant Vampire " : ""), name, age, (age == 1 ? "" : "s"))
	end
end