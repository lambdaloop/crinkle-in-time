extends Node2D

@onready var background = $Background
@onready var removable = $collisions/removable

var game_over_scene = preload("res://game_over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func handle_death():
    var game_over_screen = game_over_scene.instantiate()
    self.add_child(game_over_screen)
    

    
