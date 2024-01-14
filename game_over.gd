extends CanvasLayer


var scene_to_load = ""

# Called when the node enters the scene tree for the first time.
func _ready():
    # Run this screen even if the root node is paused.
    process_mode = Node.PROCESS_MODE_ALWAYS
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _on_retry_pressed():
    get_tree().paused = false
    get_tree().change_scene_to_file(scene_to_load)

func _on_quit_pressed():
    get_tree().quit()
