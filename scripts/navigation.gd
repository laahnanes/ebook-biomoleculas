extends Control

signal voltar
signal avancar
signal audio
signal inicio

@onready var btn_anterior: TextureButton = $HBoxContainer/BtnAnterior
@onready var btn_audio: TextureButton = $HBoxContainer/BtnAudio
@onready var btn_proxima: TextureButton = $HBoxContainer/BtnProximo
@onready var btn_inicio: TextureButton = $HBoxContainer/BtnInicio


func _ready():
	btn_anterior.pressed.connect(_on_btn_anterior_pressed)
	btn_audio.pressed.connect(_on_btn_audio_pressed)
	btn_proxima.pressed.connect(_on_btn_proxima_pressed)
	btn_inicio.pressed.connect(_on_btn_inicio_pressed)


func configurar_pagina(pagina_atual: int, total_paginas: int):
	var primeira := pagina_atual == 0
	var ultima := pagina_atual == total_paginas - 1
	# O Anterior fica invisível, mas continua ocupando o lugar dele.
	# Assim os outros botões não mudam de posição de uma página para a outra.
	btn_anterior.modulate.a = 0.0 if primeira else 1.0
	btn_anterior.disabled = primeira
	# Próximo e Voltar ao início dividem o mesmo espaço (SlotDireita).
	btn_proxima.visible = not ultima
	btn_inicio.visible = ultima


func _on_btn_anterior_pressed():
	voltar.emit()


func _on_btn_audio_pressed():
	audio.emit()


func _on_btn_proxima_pressed():
	avancar.emit()


func _on_btn_inicio_pressed():
	inicio.emit()
