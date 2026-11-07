extends Control

const PAGINAS: Array[String] = [
	"res://scenes/pages/capa.tscn",
	"res://scenes/pages/pagina5.tscn",
	"res://scenes/pages/referencias.tscn",
	"res://scenes/pages/contracapa.tscn",
]

var indice: int = 0
var pagina_atual: Node = null

@onready var paginas: Control = $Pages
@onready var navigation = $Navigation


func _ready() -> void:
	navigation.voltar.connect(func(): ir_para(indice - 1))
	navigation.avancar.connect(func(): ir_para(indice + 1))
	navigation.inicio.connect(func(): ir_para(0))
	ir_para(0)


func ir_para(i: int) -> void:
	indice = clampi(i, 0, PAGINAS.size() - 1)
	if pagina_atual != null:
		pagina_atual.queue_free()
	pagina_atual = load(PAGINAS[indice]).instantiate()
	paginas.add_child(pagina_atual)
	navigation.configurar_pagina(indice, PAGINAS.size())
