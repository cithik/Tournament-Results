--Description
This project contains a Python module that uses the PostgreSQL database to keep track of players
and matches in a game tournament. The game tournament uses the Swiss system for pairing up players
in each round: players are not eliminated, and each player is paired with another player with the
same number of wins, or as close as possible. 
   
--How To Run
1. Install virtual box and vagrant
2.Verify that Vagrant is installed and working by typing in the terminal:
  vagrant -v   # will print out the Vagrant version number
3.Verify that these files exist in the newly cloned repository:

--tournament             #folder containing tournament files
----tournament.py        #file that contains the python functions which unit tests will run on
----tournament_test.py   #unit tests for tournament.py
----tournament.sql       #postgresql database
---tournament_script.py  #creates dummy values for 6 players and 100 matches
--Vagrantfile            #template that launches the Vagrant environment
--pg_config.sh           #shell script provisioner called by Vagrantfile that performs
                          some configurations
                          
4.Launch the Vagrant Box

vagrant up   #to launch and provision the vagrant environment
vagrant ssh  #to login to your vagrant environment

Enter the Swiss Tournament

cd /
cd vagrant
cd tournament
cd Tournament-Results

5.Initialize the database

psql
vagrant=> \i tournament.sql
vagrant=> \q

6.Run the unit tests

python tournament_test.py

You should see these results:

1. countPlayers() returns 0 after initial deletePlayers() execution.
2. countPlayers() returns 1 after one player is registered.
3. countPlayers() returns 2 after two players are registered.
4. countPlayers() returns zero after registered players are deleted.
5. Player records successfully deleted.
6. Newly registered players appear in the standings with no matches.
7. After a match, players have updated standings.
8. After match deletion, player standings are properly reset.
9. Matches are properly deleted.
10. After one match, players with one win are properly paired.
Success!  All tests pass!

7.Shutdown Vagrant machine

vagrant halt

8.Destroy the Vagrant machine

vagrant destroy

**********************************************************



