extends Camera2D
#Dynamic camera moving for player. 
const no_move_zone = 160  # THis is the amount of pixels away from player where the mouse is always centered on player
const min_position = Vector2(-175, -100)  # Minimum camera position (can be adjusted)
const max_position = Vector2(175, 100)   # Maximum camera position (can be adjusted)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:  # Mouse moving activates this
		var _target = event.position - get_viewport().size * 0.5
		if _target.length() < no_move_zone:  # If mouse is within the no_move zone, then it doesn't move
			self.position = Vector2(0, 0)
		else: #Otherwise, it moves. Clamp jus applies max and min limits
			# Calculate the new position with the camera following the mouse
			var new_position = _target.normalized() * (_target.length() - no_move_zone) * 0.5
			# Apply the min and max limits to the camera position
			self.position.x = clamp(new_position.x, min_position.x, max_position.x)
			self.position.y = clamp(new_position.y, min_position.y, max_position.y)
