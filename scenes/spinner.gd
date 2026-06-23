class_name Spinner extends TextureButton

enum State {
	Idle,
	Spinning,
	Cooldown,
	Disaled
}

const THREE_TIMES_SPIN_DEG = 360 * 3

@export var spin_duration := 2
@export var cooldown := 1
@export var cost = 5
@export var type:SpinnerConfig.SpinnerType = SpinnerConfig.SpinnerType.Plus1
@export var area:PackedScene = preload("res://scenes/spinner_area.tscn")
@export var state: State = State.Idle

@onready var area_container: Control = %AreaContainer
@onready var pin: TextureRect = $Pin

@onready var areas: Array[SpinnerArea] = []

func _ready():
	if !area:
		return
		
	var area_configs = SpinnerConfig.AREAS_PER_TYPE.get(type) as Array[Dictionary]
	
	if !area_configs:
		return
		
	for child in area_container.get_children():
		child.queue_free()
		
	for area_config in area_configs:
		var area_scene = area.instantiate() as SpinnerArea
		area_scene.type = area_config.type
		area_scene.amount = area_config.amount
		area_scene.color = area_config.color
		area_scene.start_angle = area_config.start_angle
		area_scene.end_angle = area_config.end_angle
		area_scene.radius = area_config.radius
		area_container.add_child(area_scene)
		area_scene.position = Vector2(64,64)
		areas.append(area_scene)
		
func _on_pressed() -> void:
	if state != State.Idle: 
		return
		
	disabled = true
	spin()
	
func spin():
	var result = randf_range(0,360.0)
	print("result", result)
	state = State.Spinning
	await spin_animation(result)
	
	var resulted_area = get_resulted_area(result)
	if not resulted_area:
		print("nothing hit")
		return
		
	var coins_diff = resulted_area.apply()
	GameManager.update_coins(coins_diff)
	await resulted_area.animate()
	colldown_start()
	
func colldown_start():
	state = State.Cooldown
	modulate = Color("dddddd")
	await get_tree().create_timer(cooldown).timeout
	state = State.Idle
	disabled = false
	modulate = Color.WHITE
	
func spin_animation(result:float):
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(pin,"rotation_degrees",THREE_TIMES_SPIN_DEG + result, spin_duration)
	await tween.finished
	pin.rotation_degrees = result
	return
	
func get_resulted_area(result:float) -> SpinnerArea:
	for area in areas:
		var normalized_start_angle = area.start_angle
		var normalize_end_angle = area.end_angle
		var passes_360 = false
		
		if normalized_start_angle < 0:
			normalized_start_angle += 360
			
		if normalize_end_angle < 0:
			normalize_end_angle += 360
			
		if normalized_start_angle > normalize_end_angle:
			passes_360 = true
			
		if normalized_start_angle <= result and normalize_end_angle >= result:
			return area
			
		if passes_360:
			if normalized_start_angle <= result or normalize_end_angle>= result:
				return area
		
	print("Didn't hit anything: ",result)
	return
