extends Label

@onready var player = get_tree().get_first_node_in_group('Player')

func _ready():
	player.connect('on_balance_change', update_balance)

func update_balance(balance):
	text = str(balance) + ' на счету'
