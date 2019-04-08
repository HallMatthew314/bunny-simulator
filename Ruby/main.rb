load 'event_logger.rb'
load 'sex.rb'
load 'colour.rb'
load 'cause_of_death.rb'
load 'bunny.rb'
load 'colony.rb'

# Calculate unix timestamp for output filename
EventLogger.set_filename
# Begin the simulation
Colony.new