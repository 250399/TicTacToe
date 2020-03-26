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
	else
		[ $((RANDOM%2)) -eq 1 ] && comp=X  || comp=O
	fi
}

printBoard () {
	for i in {0..8}
	do
		[ $i -eq 2 -o $i -eq 5 ] && echo ${arr[$i]} || echo -n ${arr[$i]}
	done
}

reset
firstPlay
printBoard
