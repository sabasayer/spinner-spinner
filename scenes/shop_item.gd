@tool
class_name ShopItem extends HBoxContainer

signal buy(type:SpinnerConfig.SpinnerType,cost:int)

@export var type: SpinnerConfig.SpinnerType:
	set(value):
		type = value
		cost = SpinnerConfig.get_buy_cost(type)

@onready var cost_label: Label = %CostLabel
@onready var buy_button: TextureButton = %BuyButton
@onready var spinner: Spinner = $Spinner

@onready var cost: int:
	get():
		if type == null:
			return 0
			
		return SpinnerConfig.get_buy_cost(type)
	set(value):
		cost = value
		

func _ready() -> void:
	if not cost:
		return
		
	cost_label.text = "%s coins" % cost
	
	GameManager.coins_changed.connect(_on_score_changed)
	_on_score_changed(GameManager.currrent_coins,0)
	spinner.type = type
	
func _on_score_changed(new_score:int, old_score:int):
	buy_button.disabled = new_score < cost

func _on_buy_button_pressed() -> void:
	if GameManager.game_state != GameManager.GAME_STATE.PLAYING:
		return
		
	if buy_button.disabled:
		return 
	
	if not cost:
		return
		
	buy.emit(type,cost)
