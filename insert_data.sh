#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#开始清空表，以','间隔，读值
echo $($PSQL "truncate teams,games;")
sed '1d' games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
#insert teams
do
if [[ $WINNER != name ]]
then
insert_name1=$($PSQL "insert into teams(name) values('$WINNER');")
fi
if [[ $OPPONENT != name ]]
then
insert_name2=$($PSQL "insert into teams(name) values('$OPPONENT');")
fi
#insert games
get_winner_id=$($PSQL "select team_id from teams where '$WINNER'=name;")
get_opponent_id=$($PSQL "select team_id from teams where '$OPPONENT'=name;")
insert_year1=$($PSQL "insert into games(year,round,winner_goals,opponent_goals,winner_id,opponent_id) values($YEAR,'$ROUND',$WINNER_GOALS,$OPPONENT_GOALS,$get_winner_id,$get_opponent_id);")
done
