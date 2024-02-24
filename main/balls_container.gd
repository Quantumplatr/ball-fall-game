extends Node2D
class_name BallsContainer

@export var level : Level
@export var results : ResultsComponent
@export var placements : PlacementsComponent

var balls : Array[Ball] : 
	get:
		balls = []
		for child in get_children():
			if child is Ball:
				balls.append(child as Ball)
		return balls

const BALL = preload("res://ball/ball.tscn")

func _ready():
	for child in get_children():
		if child is Ball:
			balls.append(child as Ball)

func get_lowest_ball() -> Ball:
	var lowest_ball : Ball = null
	for ball in balls:
		# Skip if finished and game not over
		if ball in results.results and null in results.results:
			continue
		
		if lowest_ball == null or ball.position.y > lowest_ball.position.y:
			lowest_ball = ball
	
	return lowest_ball

func get_highest_ball() -> Ball:
	var highest_ball : Ball = null
	for ball in balls:
		# Skip if finished and game not over
		if ball in results.results and null in results.results:
			continue
			
		if highest_ball == null or ball.position.y < highest_ball.position.y:
			highest_ball = ball
	
	return highest_ball

func get_average_ball_pos() -> Vector2:
	var res = Vector2.ZERO
	var balls_used := 0
	for ball in balls:
		
		# Skip if finished and game not over
		if ball in results.results and null in results.results:
			continue
			
		res += ball.position
		balls_used += 1
	return res / balls_used


func set_balls(ball_datas: Array[BallData]) -> void:
	# Clear current
	for child in get_children():
		child.queue_free()
	
	# Add new
	var new_balls : Array[Ball] = []
	for ball_data in ball_datas:
		
		if ball_data.inactive:
			continue
		
		var new_ball = BALL.instantiate()
		new_ball.set_data(ball_data)
		add_child(new_ball)
		new_balls.append(new_ball)
		
		# Place balls randomly in start area
		var collision_shape := level.start_area.get_child(0) as CollisionShape2D
		var rect := collision_shape.shape.get_rect()
		var pos = rect.position + Vector2(randf()*rect.size.x, randf()*rect.size.y) + collision_shape.position
		new_ball.position = pos
	
	# Reset results
	results.reset_results(new_balls)
	
	# Update Placements
	placements.prep_labels()

