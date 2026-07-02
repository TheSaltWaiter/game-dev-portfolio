#This script is basis for all enemy behaviour

extends CharacterBody2D

class_name BaseEnemy

@export var enemy_damage: int = 1
@export var path_base: float = 1.25
@export var path_refresh_cooldown: float = 0.0
@export var path_refresh_step: float = 0.25

@onready var visuals: Node2D = $Visuals
@onready var velocity_component: Node = $VelocityComponent
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var hit_random_audio_player_component: AudioStreamPlayer2D = get_node_or_null("HitRandomAudioPlayerComponent")

var player: Node2D


func _ready():
	var hurtbox_component = get_node_or_null("HurtboxComponent") as HurtboxComponent
	if hurtbox_component != null:
		hurtbox_component.hit.connect(on_hit)
	
	player = get_tree().get_first_node_in_group("player") as Node2D
	path_refresh_cooldown = path_base
	navigation_agent.max_speed = velocity_component.max_speed
	if is_instance_valid(player):
		navigation_agent.target_position = player.global_position


func _physics_process(delta: float) -> void:
	if not can_move():
		velocity_component.decelerate()
		velocity_component.move(self)
		update_visual_direction()
		return

	if player == null or not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player") as Node2D
		if player == null:
			return

	path_refresh_cooldown -= delta
	if navigation_agent.is_navigation_finished() or path_refresh_cooldown <= 0.0:
		set_target()
		path_refresh_cooldown = path_base

	var next_path_position = navigation_agent.get_next_path_position()
	var move_direction = global_position.direction_to(next_path_position)
	
	velocity_component.accelerate_in_direction(move_direction, delta)
	velocity_component.move(self)
	update_visual_direction()


func can_move() -> bool:
	return true

func set_target():
	navigation_agent.target_position = player.global_position

func update_visual_direction():
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func on_hit():
	if hit_random_audio_player_component != null:
		hit_random_audio_player_component.play_random()
