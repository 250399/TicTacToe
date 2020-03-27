#!/bin/bash

reset () {
	echo Welcome to TicTacToe Program!
	read -p"Enter difficulty 1.Easy 2.Hard" difficulty
	arr=(- - - - - - - - -)
}

firstPlay () {
	read -p"Enter 1 or 0 for a toss " toss
	if [ $((RANDOM%2)) -eq $toss ]
	then
		echo You won the toss
		read -p"Please choose X or O" player
		player=${player^^}
		if [ "$player" = "X" ]
		then
			comp=O
			flag=player 
		elif [ "$player" = "O" ]
		then
			comp=X
			flag=comp
		else
			echo invalid choice
			reset
		fi
	else
		echo You lost the toss
		[ $((RANDOM%2)) -eq 1 ] && comp=X  || comp=O
		if [ "$comp" = "X" ]
		then
			player=O 
			flag=comp
		else
			player=X
			flag=player
		fi
	fi
	echo "The comp has choosen "$comp
	echo "You are "$player
}

checkWinner () {
	index1=$1
	index2=$2
	index3=$3
	if [ "${arr[$index1]}" != "-" ]
	then
		[ "${arr[$index1]}" = "${arr[$index2]}" -a "${arr[$index2]}" = "${arr[$index3]}" ] && winner=${arr[$index1]} || return 0
	fi
}

checkTwo () {
	if [ "$flag" = "player" ]
	then
		return 
	fi
	index1=$1
	index2=$2
	index3=$3
	checkCompWin=$4
	if [ "${arr[$index1]}" = "${arr[$index2]}" -a "${arr[$index1]}" != "-" -a "${arr[$index3]}" = "-" -a "${arr[$index1]}" = "$checkCompWin" ] 
	then
		arr[$index3]=$comp
	 	flag=player
		remMoves=$((remMoves-1))
		printBoard
	fi
	if [ "${arr[$index1]}" = "${arr[$index3]}" -a "${arr[$index1]}" != "-" -a "${arr[$index2]}" = "-"  -a "${arr[$index1]}" = "$checkCompWin" ]
	then
	 	arr[$index2]=$comp
		remMoves=$((remMoves-1))
	 	flag=player
		printBoard
	fi
	if [ "${arr[$index3]}" = "${arr[$index2]}" -a "${arr[$index3]}" != "-" -a "${arr[$index1]}" = "-"  -a "${arr[$index2]}" = "$checkCompWin" ]
	then
		arr[$index1]=$comp
		flag=player
		printBoard
		remMoves=$((remMoves-1))
	fi

}

printBoard () {
	echo
	for i in {0..8}
	do
		[ $i -eq 2 -o $i -eq 5 ] && echo ${arr[$i]} || echo -n ${arr[$i]}
	done
	echo
}

randomPlay () {
	pos=$((RANDOM%9))
	if [ "${arr[$pos]}" = "-" ] 
	then 
		arr[$pos]=$comp 
		remMoves=$((remMoves-1))
	else
		randomPlay
	fi
	flag=player
	printBoard

}

checkCorner () {
	index=0
	[ "$flag" = "player" ] && return || :
	[ "${arr[0]}" = "-" ] && corner[$((index++))]=0 || :
	[ "${arr[2]}" = "-" ] && corner[$((index++))]=2 || :
	[ "${arr[6]}" = "-" ] && corner[$((index++))]=6 || :
	[ "${arr[8]}" = "-" ] && corner[$((index++))]=8 || :
	length=${#corner[@]}
	if [ $length -eq 0 ]
	then
		return 0
	elif [ $length -eq 1 ]
	then
		arr[${corner[@]}]=$comp
		remMoves=$((remMoves-1))
		printBoard
		flag=player
	else
		echo  "ASDSADASDSA"
		arr[${corner[$((RANDOM%length))]}]=$comp
		remMoves=$((remMoves-1))
		flag=player
		printBoard
	fi
	return 1
}

takeCenter () {
	[ "$flag" = "player" ] && return || :
	[ "${arr[4]}" = "-" ] && arr[5]=$comp || return
	remMoves=$((remMoves-1))
	flag=player
	printBoard
}

winCheck () {
	checkFlag=$1
	checkTwo 0 1 2 $checkFlag
	checkTwo 3 4 5 $checkFlag
	checkTwo 6 7 8 $checkFlag
	checkTwo 0 4 8 $checkFlag
	checkTwo 2 4 6 $checkFlag
	checkTwo 0 3 6 $checkFlag
	checkTwo 1 4 7 $checkFlag
	checkTwo 2 5 8 $checkFlag
}

play () {
	if [ "$flag" =  "player" ]
	then
		read -p"Enter position" pos 
		if [ "${arr[$((pos-1))]}" = "-" -a $pos -ge 1 -a $pos -le 9 ]
		then
	 		arr[$((pos-1))]=$player
			remMoves=$((remMoves-1))
			printBoard
		else
	 		echo "Please enter any another locaation"
			printBoard
			play
		fi
		flag=comp
	elif [ $difficulty -eq 2 -a "$flag" = "comp" ]
	then
		winCheck $comp
		winCheck $player
		[ "$flag" = "comp" ] && checkCorner || :
		[ $? -eq 0 ] && takeCenter || : 
		[ "$flag" = "comp" ] && randomPlay || :
	else
		randomPlay
	fi
} 
flag=0
remMoves=9
reset
firstPlay
printBoard
winner=no

while true
do
	if [ $remMoves -lt 5 ]
	then
		checkWinner 0 1 2
		checkWinner 3 4 5
		checkWinner 6 7 8
		checkWinner 0 4 8
		checkWinner 2 4 6
		checkWinner 0 3 6
		checkWinner 1 4 7
		checkWinner 2 5 8
		if [ "$winner" = "Tie" ]
		then
			echo Tie
			break
		elif [ "$winner" = "X" -o "$winner" = "O" ]
		then
			echo $winner "Won"
			break
		fi
	fi
	if [ $remMoves -eq 0 ]
	then
		echo "Tie"
		break
	fi
	play
done
