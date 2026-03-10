extends Control

@onready var hud: CanvasLayer = $".."
@onready var time_amount: Label = $MarginContainer/TimeContainer/MarginContainer2/TimeAmount
@onready var life_amount: Label = $MarginContainer/LifeContainer/LifeAmount
@onready var clock_timer: Timer = $ClockTimer
@onready var coin_amount: Label = $MarginContainer/MarginContainer/CoinContainer/CoinAmount

var default_minutes = 1
var default_seconds = 0
var minutes = 0
var seconds = 0

signal time_is_up()

func _ready() -> void:
	default_minutes = hud.default_minutes
	default_seconds = hud.default_seconds
	coin_amount.text = str("%04d" % Globals.player_coins)
	life_amount.text = str("%02d" % Globals.player_life)
	time_amount.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)
	reset_clock_timer()

func _process(_delta: float) -> void:
	if !is_inside_tree():
		print("Node fora da árvore")
		print_stack()
	coin_amount.text = str("%04d" % Globals.player_coins)
	life_amount.text = str("%02d" % Globals.player_life)
	if minutes == 0 and seconds == 0:
		emit_signal("time_is_up")

func _on_clock_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1
	if minutes == 0 and seconds <= 0:
		time_amount.text = "00:00"
	else:
		time_amount.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds
