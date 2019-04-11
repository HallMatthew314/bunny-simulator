# Bunny Simulator - Ruby Implementation

## Usage

 1. Compile with `$ gcc -o bunny-sim bunny-sim.c`
 2. Run with `$ ./bunny-sim`

## Todo list:
 - ~~Bunny objects~~
 - ~~(Linked) list of bunny objects~~
 - On start, five random-coloured bunnies
 - Bunnies age one year after each turn
 - Bunny reproduction, # of new bunnies = # of mature females
 - Bunnies have same colour as their mothers
 - Radioactive Mutant Vampire Bunnies do not count towards breeding
 - Radioactive Mutant Vampire Bunnies infect other bunnies
 - Program prints colony information for each year
 - Program outputs events
 - Screen output is also written to a file
 - Food shortages kill half of the population when it exceeds 1,000 bunnies
 - Program ends when all bunnies are dead

## Extras:
 1. Modify the program to run in real time, with each turn lasting 2 seconds, and a one second pause between each announement.
 2. Allow the user to hit the 'k' key to initiate a mass rabit cull! which causes half of all the rabits to be killed (randomly chosen).
 3. Modify the program to place the rabits in an 80x80 grid:
   - Have the rabits move one space each turn randomly.
   - Mark juvenile males with m, adult males w/ M,
   - juvenile females w/ f, adult females w/ F
   - radioactive mutant vampire bunnies with X
   - Modify the program so that radioactive mutant vampire bunnies only convert bunnies that end a turn on an adjacent square.
   - Modify the program so that new babies are born in an empty random adjacent square next to the mother bunny. (if no empty square exits then the baby bunny isn't born)
 4. Modify the program so that it saves each turn to a file and can play back at accelearted speed all subsequent turns.

