extends CharacterBody2D


signal Clicked(itself)

@onready var Lambo = preload("res://player/Lambo Car.png")
@onready var DR650 = preload("res://player/DR 650.png")
@onready var RedCar = preload("res://player/Carg Car.png")
@onready var Mustang = preload("res://player/Mustang Car.png")
@onready var NS250 = preload("res://player/NS 250.png")

@onready var VehicleSprite = $VehicleSprite

var Speed = 200
var RotSpeed = 4 # Before 1.5
var RotDir = 0
var Dir = 0
var CanMove = false


func _ready():
	PickRandomVehi()


func PickRandomVehi():
	randomize()
	var NumRan = randi_range(1, 5)
	if NumRan == 1:
		VehicleSprite.texture = Lambo
	elif NumRan == 2:
		VehicleSprite.texture = DR650
	elif NumRan == 3:
		VehicleSprite.texture = RedCar
	elif NumRan == 4:
		VehicleSprite.texture = Mustang
	elif NumRan == 5:
		VehicleSprite.texture = NS250


func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		emit_signal("Clicked", self)


func get_input():
	RotDir = Input.get_axis("left", "right")
	Dir = Input.get_axis("up", "down")
	velocity = transform.y * Dir * Speed


func _physics_process(delta):
	if CanMove:
		get_input()
		ApplyRot(delta)
		move_and_slide()


func ApplyRot(Delta):
	if velocity.x != 0 or velocity.y != 0:
		
		if Dir == -1:
			RotDir = RotDir * 1
		else:
			RotDir = RotDir * -1
		
		rotation += RotDir * RotSpeed * Delta
