#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -t -A -c"



OUTPUT(){
  TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$ATOMIC_NUMBER ")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER ")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER ")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER ")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER ")

  echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
}

INFORMATION_CHECKED () {

  if [[ $ELEMENT_INFO =~ ^[0-9]+$ ]]
    then 
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$ELEMENT_INFO ")
    else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ELEMENT_INFO' OR name='$ELEMENT_INFO'")
  fi

  if [[ -z $ATOMIC_NUMBER ]]
    then 
    echo "I could not find that element in the database."
  else
    OUTPUT
  fi

}

ELEMENT_INFO=$1
if [[ -z $ELEMENT_INFO ]]
then
 echo "Please provide an element as an argument."
else
INFORMATION_CHECKED
fi





