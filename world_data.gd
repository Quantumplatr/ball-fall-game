class_name WorldData extends Resource

@export var name := "Save Data"
@export var balls: Array[BallData]

func add_ball() -> BallData:
	var new_ball = BallData.new()
	balls.append(new_ball)
	return new_ball

func delete_ball(index: int):
	balls.remove_at(index)
