class EventLogger
  
  def self.set_filename
    @@filename = format("bunny_sim_log_%s.txt", Time.now.to_i)
  end

  def self.output(message)
    puts message
    File.open(@@filename, 'a') { |f| f.write(message + "\n") }
  end

  def self.announce_year_start(year)
    message = format("-- START OF YEAR %s --", year)
    EventLogger.output(message)
  end

  def self.announce_birth(name, rmvb)
    # Refer to a bunny as either 'Bunny' or 'Radioactive Mutant Vampire Bunny'
    message = format("%sBunny %s was born!", (rmvb == true ? 'Radioactive Mutant Vampire ' : ''), name)
    EventLogger.output(message)
  end

  def self.announce_older(name, rmvb, age)
    message = format("%sBunny %s is now %s year%s old", (rmvb == true ? 'Radioactive Mutant Vampire ' : ''), name, age, (age == 1 ? '' : 's'))
    EventLogger.output(message)
  end

  def self.announce_death(name, rmvb, age, cause: CauseOfDeath::OLD_AGE)
    message = format("%sBunny %s has died of %s (age %s)", (rmvb == true ? 'Radioactive Mutant Vampire ' : ''), name, CauseOfDeath.value_to_string(cause), age)
    EventLogger.output(message)
  end

  def self.announce_infection(name)
    message = format("Bunny %s was infected!", name)
    EventLogger.output(message)
  end

  def self.announce_famine(population)
    message = format("The colony's population has reached %s, resulting in a food shortage.", population)
    EventLogger.output(message)
  end
end