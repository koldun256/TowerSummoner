extends Button

func set_cost(cost):
	$Label.text = str(cost)

func set_icon(icon: Texture2D):
	$Icon.texture = icon
