load 'sex.rb'
load 'colour.rb'
load 'bunny.rb'
load 'colony.rb'

# Begin the simulation
c = Colony.new

c.bunnies.each { |b| puts b }