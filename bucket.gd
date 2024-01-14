extends Area2D

@onready var _animation = $AnimatedSprite2D

var spilled = false

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func spill():
    if spilled: return
    spilled = true
    _animation.play("spill")
    _animation.connect("animation_finished", finished_spill)

func finished_spill():
    _animation.disconnect("animation_finished", finished_spill)
    print("finished spilling!!")
    for area in $SpillArea.get_overlapping_areas():
        if area is Fire:
            area.extinguish()
    
    

func _on_area_entered(area):
    if area.get_parent() is Player:
        spill()
