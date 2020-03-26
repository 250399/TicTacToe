#!/bin/bash

reset () {
	echo Welcome to TicTacToe Program!
	arr=(- - - - - - - - -)
}

firstPlay () {
	read -p"Enter 1 or 0 for a toss " toss
	if [ $((RANDOM%2)) -eq $toss ]
	then
		read -p"Enter X or O" player
		[[ "$player" -eq "X" ]] && comp=O || comp=X
	else
		[ $((RANDOM%2)) -eq 1 ] && comp=X  || comp=O
		[[ "$comp" -eq "X" ]] && player=O || player=X
	fi
}

checkWinner () {
	[ arr[$1] -eq arr[$2] -a arr[$2] -eq arr[$3]] && return arr[$1] || return break 
	if [ $remMoves -eq 1 ]
	then
	return break
	fi
}

printBoard () {
	for i in {0..8}
	do
		[ $i -eq 2 -o $i -eq 5 ] && echo ${arr[$i]} || echo -n ${arr[$i]}
	done
	echo
}

play () {
	if [ "$flag" =  "player" ]
	then
	read -p"Enter position" pos
	if [ "${arr[$pos]}" = "-" ] 
	then
	 	arr[$pos]=$player 
		remMoves=$((remMoves-1))	
	else
	 	echo "Please enter any another locaation"
		printBoard
		play
	fi
	flag=comp
	else
	pos=$((RANDOM%remMoves))
	if [ "${arr[$pos]}" = "-" ] 
	then 
		arr[$pos]=$comp 
		remMoves=$((remMoves-1))
	else
		play
		remMoves=$((remMoves-1))
	fi 
	flag=player
	fi
	printBoard
}
flag=player
remMoves=9
reset
firstPlay
printBoard
while true
do
	play
done
