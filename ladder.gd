extends Node2D

@onready var _animation_player = $AnimatedSprite2D

var folded = true

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_unfold_body_entered(body):
    print("body entered: ", body.name)


func _on_unfold_area_entered(area):
    print("area entered: ", area.name)
    if folded and area.get_parent() is Player:
        unfold()
        
func unfold():
    _animation_player.play("defold")
    folded = false
    # handle areas already in the place
    for area in $climb.get_overlapping_areas():
        _on_climb_area_entered(area)    

func _on_climb_area_entered(area):
    var parent = area.get_parent()
    if parent is Player:
        parent.climb()
