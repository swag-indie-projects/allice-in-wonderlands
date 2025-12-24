shader_type canvas_item;

uniform sampler2D overlay_tex : repeat_enable, filter_nearest;
uniform float scale = 0.007;
varying vec2 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	// Called for every ertex the material is visible on.
	
}

void fragment() {
	float mix_amount = floor(COLOR.r);
	vec4 overlay_color = texture(overlay_tex, world_position * scale);
	
	COLOR = mix(COLOR, overlay_color, mix_amount);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
