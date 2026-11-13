extends Control

const DNA_ALTURA := 480.0
const CURSO := 440.0
const LIMIAR := 0.01    
const GANHO := 6000.0
const FORCA_MAX := 600.0

@onready var dna: Control = %DNA
@onready var aberto: Control = %Aberto
@onready var aberto_img: TextureRect = %AbertoImg
@onready var fechado: Control = %Fechado
@onready var helicase: RigidBody2D = %Helicase

var captura: AudioEffectCapture
var _t_debug := 0.0
 
func _ready() -> void:
	if OS.get_name() == "Android":
		OS.request_permissions()
	var bus := AudioServer.get_bus_index("Mic")
	captura = AudioServer.get_bus_effect(bus, 0) as AudioEffectCapture
	helicase.gravity_scale = 0.0
	helicase.position = Vector2(dna.position.x + 120.0, dna.position.y + CURSO)
	helicase.y_min = dna.position.y

func _physics_process(_delta: float) -> void:
	helicase.empurrao = _forca_do_sopro()

func _process(delta: float) -> void:
	var h := clampf(helicase.position.y - dna.position.y, 0.0, DNA_ALTURA)
	fechado.position = Vector2.ZERO
	fechado.size = Vector2(240.0, h)
	aberto.position = Vector2(0.0, h)
	aberto.size = Vector2(240.0, DNA_ALTURA - h)
	aberto_img.position = Vector2(0.0, -h)

func _forca_do_sopro() -> float:
	var n := captura.get_frames_available()
	var nivel := 0.0
	if n > 0:
		var soma := 0.0
		for v in captura.get_buffer(n):
			soma += v.x * v.x
		nivel = sqrt(soma / n)
	_t_debug += get_physics_process_delta_time()
	if _t_debug > 0.5:
		_t_debug = 0.0
		print("nivel mic: ", snappedf(nivel, 0.001))
	if Input.is_key_pressed(KEY_B):  # só para testar sem microfone
		nivel = 0.1
	return clampf((nivel - LIMIAR) * GANHO, 0.0, FORCA_MAX)
