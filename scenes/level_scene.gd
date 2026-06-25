extends Node2D

@onready var spinner_container: FlowContainer = %SpinnerContainer
@onready var shop_spinners: VBoxContainer = %ShopSpinners

@export var shop_item_scene:PackedScene = preload("res://scenes/shop_item.tscn")
@export var spinner_scene:PackedScene = preload("res://scenes/spinner.tscn")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	for child in shop_spinners.get_children():
		child.queue_free()
	
	for child in spinner_container.get_children():
		child.queue_free()
		
	add_shop_items()
	add_item(SpinnerConfig.SpinnerType.Plus1)
	GameManager.playing()

func add_shop_items():
	var types = [
		SpinnerConfig.SpinnerType.Plus1,
		SpinnerConfig.SpinnerType.Plus2,
		SpinnerConfig.SpinnerType.Plus5Minues1,
		SpinnerConfig.SpinnerType.Jackpot,
	]
	for type in types:
		var shop_item = shop_item_scene.instantiate() as ShopItem
		shop_item.type = type
		shop_item.buy.connect(on_buy)
		shop_spinners.add_child(shop_item)

func add_item(type:SpinnerConfig.SpinnerType):
	var spinner = spinner_scene.instantiate() as Spinner
	spinner.type = type
	spinner_container.add_child(spinner)

func on_buy(type:SpinnerConfig.SpinnerType,cost: int):
	GameManager.update_coins(-cost)
	add_item(type)
