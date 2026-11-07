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
	btn_anterior.visible = pagina_atual > 0
	btn_proxima.visible = pagina_atual < total_paginas - 1
	btn_inicio.visible = pagina_atual == total_paginas - 1


func _on_btn_anterior_pressed():
	voltar.emit()


func _on_btn_audio_pressed():
	audio.emit()


func _on_btn_proxima_pressed():
	avancar.emit()


func _on_btn_inicio_pressed():
	inicio.emit()
