extends Node
class_name ResultsComponent

signal on_game_over(res: Array[Ball])

@export var balls_container : BallsContainer

var results : Array[Ball]
var winners : Array[Ball]
var losers : Array[Ball]

func _ready():
		
	reset_results()

func _on_ball_reached_end(ball: Ball):
	ball_won(ball)
	
func _on_ball_reached_loss(ball: Ball):
	ball_lost(ball)
	
func reset_results(with_balls=null):
	
	var balls = with_balls if with_balls != null else balls_container.balls
	
	for ball in balls:
		if not ball.on_reached_end.is_connected(_on_ball_reached_end):
			ball.on_reached_end.connect(_on_ball_reached_end)
			
		if not ball.on_reached_loss.is_connected(_on_ball_reached_loss):
			ball.on_reached_loss.connect(_on_ball_reached_loss)
		
	results = []
	for i in balls.size():
		results.append(null)
	
	winners = []
	losers = []

func ball_won(ball: Ball):
	if ball in results:
		return
		
	# Add ball to first available slot in result
	for i in results.size():
		if results[i] == null:
			results[i] = ball
			winners.append(ball)
			
			# If first, add win to ball data
			if i == 0:
				ball.ball_data.wins += 1
				SaveManager.save()
			
			break
	
	if null not in results:
		on_game_over.emit(results)

func ball_lost(ball: Ball):
	if ball in results:
		return
	
	# Add ball to last available slot in result
	for i in range(results.size() - 1, 0, -1):
		if results[i] == null:
			results[i] = ball
			losers.append(ball)
	
			# If first, add win to ball data
			# Should only happen in lost if all balls die
			if i == 0:
				ball.ball_data.wins += 1
				SaveManager.save()
				
			break
	
	if null not in results:
		on_game_over.emit(results)
