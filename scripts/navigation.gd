extends Control

signal voltar
signal avancar
signal audio
signal inicio

@onready var btn_anterior: TextureButton = $HBoxContainer/BtnAnterior
@onready var btn_audio: TextureButton = $HBoxContainer/BtnAudio
@onready var btn_proxima: TextureButton = $HBoxContainer/BtnProximo
@onready var btn_inicio: TextureButton = $HBoxContainer/BtnInicio

const escala_hover:= 1.06
const escala_pressed:= 0.95
const brilho_hover:= Color(1.15, 1.15, 1.15, 1)
const time:= 0.12

var _tweens: Dictionary = {}

func _ready():
	btn_anterior.pressed.connect(_on_btn_anterior_pressed)
	btn_audio.pressed.connect(_on_btn_audio_pressed)
	btn_proxima.pressed.connect(_on_btn_proxima_pressed)
	btn_inicio.pressed.connect(_on_btn_inicio_pressed)
	for btn in [btn_anterior, btn_audio, btn_proxima, btn_inicio]:
		_configurar_feedback(btn)

func configurar_pagina(pagina_atual: int, total_paginas: int):
	var primeira := pagina_atual == 0
	var ultima := pagina_atual == total_paginas - 1
	btn_anterior.modulate.a = 0.0 if primeira else 1.0
	btn_anterior.disabled = primeira
	btn_proxima.visible = not ultima
	btn_inicio.visible = ultima
	for btn in [btn_anterior, btn_audio, btn_proxima, btn_inicio]:
		_restaurar(btn)

func _on_btn_anterior_pressed():
	voltar.emit()


func _on_btn_audio_pressed():
	audio.emit()


func _on_btn_proxima_pressed():
	avancar.emit()


func _on_btn_inicio_pressed():
	inicio.emit()
	
	
func _configurar_feedback(btn: TextureButton) -> void:
	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn.pivot_offset = btn.size / 2.0
	btn.resized.connect(func(): btn.pivot_offset = btn.size / 2.0)
	btn.mouse_entered.connect(func(): _animar(btn, escala_hover, brilho_hover))
	btn.mouse_exited.connect(func(): _animar(btn, 1.0, Color.WHITE))
	btn.button_down.connect(func(): _animar(btn, escala_pressed, brilho_hover))
	btn.button_up.connect(func(): _animar(
		btn,
		escala_hover if btn.is_hovered() else 1.0,
		brilho_hover if btn.is_hovered() else Color.WHITE
	))
 
 
func _animar(btn: TextureButton, escala: float, brilho: Color) -> void:
	if btn.disabled:
		return
	if _tweens.has(btn):
		_tweens[btn].kill()
	var tween := create_tween().set_parallel(true)
	_tweens[btn] = tween
	tween.tween_property(btn, "scale", Vector2(escala, escala), time) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn, "self_modulate", brilho, time)
 
 
func _restaurar(btn: TextureButton) -> void:
	if _tweens.has(btn):
		_tweens[btn].kill()
	btn.scale = Vector2.ONE
	btn.self_modulate = Color.WHITE
