extends Node2D


const MAX_NUM_OF_VEHICLE = 8

@onready var Vehi = preload("res://player/player.tscn")

@onready var Light_1A = $MovilApp/ScreenApp/DispPosLight/Light_1A
@onready var Light_1B = $MovilApp/ScreenApp/DispPosLight/Light_1B
@onready var Light_1C = $MovilApp/ScreenApp/DispPosLight/Light_1C
@onready var Light_2A = $MovilApp/ScreenApp/DispPosLight/Light_2A
@onready var Light_2B = $MovilApp/ScreenApp/DispPosLight/Light_2B
@onready var Light_2C = $MovilApp/ScreenApp/DispPosLight/Light_2C
@onready var Light_2D = $MovilApp/ScreenApp/DispPosLight/Light_2D

@onready var VehiContainer = $PlayerContainer
@onready var Phone = $MovilApp


func _ready():
	Phone.visible = true
	CheckVehiBefore()


func CheckVehiBefore():
	if VehiContainer.get_child_count() != 0:
		VehiContainer.get_child(0).CanMove = true


func SetPosState(Pos : ColorRect, state: int):
	match state:
		0:
			Pos.color = Color(1, 0, 0)
		1:
			Pos.color = Color(0, 1, 0)


func _on_sensor_p_1_a_body_entered(body):
	SetPosState(Light_1A, 0)


func _on_sensor_p_1_a_body_exited(body):
	if !$ParkSensors/Sensor_P1_A.has_overlapping_bodies():
		SetPosState(Light_1A, 1)


func _on_sensor_p_1_b_body_entered(body):
	SetPosState(Light_1B, 0)


func _on_sensor_p_1_b_body_exited(body):
	if !$ParkSensors/Sensor_P1_B.has_overlapping_bodies():
		SetPosState(Light_1B, 1)


func _on_sensor_p_1_c_body_entered(body):
	SetPosState(Light_1C, 0)


func _on_sensor_p_1_c_body_exited(body):
	if !$ParkSensors/Sensor_P1_C.has_overlapping_bodies():
		SetPosState(Light_1C, 1)


func _on_sensor_p_2_a_body_entered(body):
	SetPosState(Light_2A, 0)


func _on_sensor_p_2_a_body_exited(body):
	if !$ParkSensors/Sensor_P2_A.has_overlapping_bodies():
		SetPosState(Light_2A, 1)


func _on_sensor_p_2_b_body_entered(body):
	SetPosState(Light_2B, 0)


func _on_sensor_p_2_b_body_exited(body):
	if !$ParkSensors/Sensor_P2_B.has_overlapping_bodies():
		SetPosState(Light_2B, 1)


func _on_sensor_p_2_c_body_entered(body):
	SetPosState(Light_2C, 0)


func _on_sensor_p_2_c_body_exited(body):
	if !$ParkSensors/Sensor_P2_C.has_overlapping_bodies():
		SetPosState(Light_2C, 1)


func _on_sensor_p_2_d_body_entered(body):
	SetPosState(Light_2D, 0)


func _on_sensor_p_2_d_body_exited(body):
	if !$ParkSensors/Sensor_P2_D.has_overlapping_bodies():
		SetPosState(Light_2D, 1)


func _on_area_out_body_entered(body):
	body.queue_free()


func _on_player_clicked(itself):
	AllStandBy()
	itself.CanMove = true


func AllStandBy():
	for i in get_tree().get_nodes_in_group("vehi"):
		i.CanMove = false


func _on_button_add_vehi_button_up():
	if VehiContainer.get_child_count() <= MAX_NUM_OF_VEHICLE:
		AllStandBy()
		var vehi = Vehi.instantiate()
		vehi.connect("Clicked", self._on_player_clicked)
		vehi.CanMove = true
		vehi.position = $PosSpawnVehi.position
		vehi.scale = Vector2(0.7, 0.7)
		VehiContainer.call_deferred("add_child", vehi)
