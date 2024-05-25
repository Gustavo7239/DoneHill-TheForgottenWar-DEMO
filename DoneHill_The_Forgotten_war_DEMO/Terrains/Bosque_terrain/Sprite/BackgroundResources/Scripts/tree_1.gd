extends Sprite2D

@onready var cpu_particles_2d = $CPUParticles2D



func _process(delta):
	cpu_particles_2d.scale_amount_max = scale.x/2.5
	cpu_particles_2d.scale_amount_min = cpu_particles_2d.scale_amount_max/2
