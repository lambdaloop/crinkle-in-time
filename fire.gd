extends Area2D
class_name Fire

func extinguish():
    print("fire extinguished!!")
    self.visible = false
    remove_child(self)
    queue_free()
