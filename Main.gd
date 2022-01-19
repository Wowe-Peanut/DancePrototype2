extends Node2D


onready var song: AudioStreamPlayer = $AudioStreamPlayer
onready var bpm: float = 126
onready var spb = 60/bpm

var start_delay = 3
var time_begin
var time_delay
var last_beat


func _ready():
	yield(get_tree().create_timer(start_delay), "timeout")
	
	time_begin = OS.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency() + start_delay
	song.play()
	



func _physics_process(delta):
	#Seconds into the song (starting at the first beat)
	var song_position = ((OS.get_ticks_usec()-time_begin) / 1000000.0)-time_delay
	var beat = floor(song_position/spb)
	if beat != last_beat:
		print(beat)
		last_beat = beat




