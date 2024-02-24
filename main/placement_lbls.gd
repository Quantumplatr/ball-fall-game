extends VBoxContainer
class_name PlacementsComponent

@export var balls_container : BallsContainer
@export var results : ResultsComponent

func _ready():
	prep_labels()



func _process(delta):
	var ball_list := get_ball_order()
	
	# Update
	set_labels(ball_list)

func get_ball_order() -> Array[Ball]:
	# Start with results
	var ordered = results.results.duplicate()
	
	# Get balls not in order
	var not_finished = []
	for ball in balls_container.balls:
		if ball not in ordered:
			not_finished.append(ball)
	
	# Sort not_finished by position (least y is best)
	not_finished.sort_custom(func(a: Ball,b: Ball):
		return a.global_position.y > b.global_position.y
	)
	
	# Slot not_finished into ordered
	var j = 0 # Index in not_finished
	for i in ordered.size():
		if !ordered[i]:
			ordered[i] = not_finished[j]
			j += 1
	
	return ordered

func prep_labels():
	# Prep labels
	for child in get_children():
		child.queue_free()
		
	for ball in balls_container.balls:
		add_child(Label.new())

func set_labels(balls: Array[Ball]):
	for index in balls.size():
			
		var lbl = get_child(index) as Label
		
		lbl.text = "%s. %s" % [index + 1, balls[index].ball_data.name]
		
		if balls[index] in results.winners:
			lbl.add_theme_color_override("font_color", Color.GREEN)
		elif balls[index] in results.losers:
			lbl.add_theme_color_override("font_color", Color.RED)
