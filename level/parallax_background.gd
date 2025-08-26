extends ParallaxBackground



var screen_size := Vector2(1024, 600)

func _ready():
	offset = -(screen_size / 2) + ((screen_size / 2) * scroll_base_scale)
