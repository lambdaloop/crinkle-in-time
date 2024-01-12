extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

    #print(self.get_tree())
    for child in get_children():
        if child is ConnectionPoint:
            child.connect("is_clicked", _on_any_connection_pt_clicked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
    
func _on_any_connection_pt_clicked(connection_pt):
    # line drawing logic here.
    print("(%d, %d)" % [connection_pt.position.x, connection_pt.position.y])
    #print("yo.")
