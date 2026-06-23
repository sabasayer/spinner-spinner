extends Node

signal coins_changed(coins:int,old_coins:int)

var currrent_coins :int = 0

func update_coins(coins_diff:int):
	var old_coins = currrent_coins
	currrent_coins += coins_diff
	if currrent_coins < 0:
		currrent_coins = 0
	coins_changed.emit(currrent_coins,old_coins)
