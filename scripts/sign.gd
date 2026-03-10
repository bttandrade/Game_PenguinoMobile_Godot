extends Node2D

@export var lines: Array[String] = []

@onready var sprite: Sprite2D = $Sprite2D
@onready var sign_area: Area2D = $SignArea
@onready var spawn_place: Marker2D = $SpawnText

var player_inside = false
var coin_line: String = ""
var coin_line2: String = ""
var coin_line3: String = ""

func _ready() -> void:
	sprite.hide()

func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact") and !DialogManager.is_message_active:
		if get_tree().current_scene.name == "TheEnd":
			success_rate()
			lines = [
			"Bem-vindo de volta Penguino!",
			"Sei que teve uma aventura e tanto ao retornar.",
			"Mas vamos ver quanto as moedas que trouxe!",
			coin_line, coin_line2, coin_line3, 
			". . . E que tal começar nos contando tudo sobre sua aventura?"]
		DialogManager.start_message(spawn_place.global_position, lines)

func _on_sign_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_body"):
		player_inside = true
		sprite.show()

func _on_sign_area_body_exited(_body: Node2D) -> void:
	player_inside = false
	sprite.hide()
	
	if DialogManager.is_message_active:
		DialogManager.end_message()

func success_rate():
		
	if Globals.player_coins <= 0:
		coin_line = "Hmmm . . . Parece que não conseguiu nenhuma moeda dessa vez."
		coin_line2 = "Mas pelo menos retornou em segurança, ficamos felizes."
		coin_line3 = "Não se preocupe, iremos enviar outro Penguino na próxima estação."
	elif Globals.player_coins >= 1 and Globals.player_coins <= 39:
		coin_line = "Hmmm . . . Parece que conseguiu algumas moedas dessa vez."
		coin_line2 = "Que bom, com elas vamos aguentar mais uma estação!"
		coin_line3 = "Não se preocupe, na próxima iremos enviar outro Penguino, venha e descanse!"
	elif Globals.player_coins >= 40 and Globals.player_coins <= 99:
		coin_line = "Hmmm . . . Parece que conseguiu bastante moedas dessa vez!"
		coin_line2 = "Que ótimo! Agora não precisaremos enviar outro Penguino por duas ou três estações!"
		coin_line3 = "Venha e descanse Penguino, vamos comemorar!"
	elif Globals.player_coins >= 100:
		coin_line = "Uaaauu!! Parece que conseguiu um MONTE de moedas dessa vez!"
		coin_line2 = "Você é um héroi!! Agora não precisaremos enviar outro Penguino por várias estações!"
		coin_line3 = "Venha e descanse Penguino, vamos comemorar como nunca antes!"
