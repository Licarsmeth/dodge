extends Node
@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func game_over():
	$scoreTimer.stop()
	$mobTimer.stop()
	
func new_game():
	score = 0
	$Player.start($startPosition.position)
	$startTimer.start()


func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$mobTimer.start()
	$scoreTimer.start()

	
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
#random location 
	var mob_spawn_location = $mobPath/mobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	$mobTimer.set_wait_time(randf() + 0.1) #0.1
	
#set mob direction perpendicular to path direction 
	var direction = mob_spawn_location.rotation + PI/2 
	
#set mob position to random location 
	mob.position = mob_spawn_location.position 
	
#add randomness to direction 
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
#spawn mob by adding it to main scene
	add_child(mob)
