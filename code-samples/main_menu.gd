#This script is for control and visual styles of the main menu
#Button connections
#Transitions
#Automatic Animations

extends CanvasLayer


var options_scene = preload("res://scenes/ui/options_menu.tscn")
@onready var top_runs_panel: MarginContainer = $MarginContainer/BoxContainer/TopRunsPanel
@onready var container_2: Container = $MarginContainer/BoxContainer/Container2
@onready var title_component_player: AnimationPlayer = $TitleComponent/AnimationPlayer
@onready var title_image: Sprite2D = $TitleComponent/AnimationPlayer/MarginContainer/BoxContainer/Sprite2D



func _ready() -> void:
	update_menu_layout()

	$%PlayButton.pressed.connect(on_play_pressed)
	$%UpgradesButton.pressed.connect(on_upgrades_pressed)
	$%OptionsButton.pressed.connect(on_options_pressed)
	$%CreditsButton.pressed.connect(on_credits_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)
	title_component_player.play("default")


func on_play_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_upgrades_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://scenes/ui/meta_menu.tscn")


func on_options_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))
	title_image.visible = false
	top_runs_panel.visible = false
	container_2.visible = true


func on_credits_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://scenes/ui/credits.tscn")


func on_quit_pressed():
	get_tree().quit()


func update_menu_layout():
	if ScoreProgression.has_runs():
		top_runs_panel.visible = true
		container_2.visible = false
	else:
		top_runs_panel.visible = false
		container_2.visible = true


func on_options_closed(options_instance: Node):
	options_instance.queue_free()
	title_image.visible = true
	update_menu_layout()
