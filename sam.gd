extends Player
class_name Sam

func _physics_process(delta):
    velocity.x = 50
    super._physics_process(delta)
    

func _on_area_2d_area_entered(area):
    #print(area.name)
    if area.name == "testarea":
        print("test")
        get_parent().background.texture = load("res://assets/background-1A-filtered-cut.jpg")
        get_parent().removable.position.y = -10000

