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

reset
firstPlay
