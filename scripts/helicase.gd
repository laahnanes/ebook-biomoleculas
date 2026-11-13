extends RigidBody2D

var empurrao := 0.0   # positivo = sobe
var y_min := 0.0

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	state.apply_central_force(Vector2(0.0, -empurrao))
	if state.transform.origin.y < y_min:
		var t := state.transform
		t.origin.y = y_min
		state.transform = t
		state.linear_velocity = Vector2.ZERO
