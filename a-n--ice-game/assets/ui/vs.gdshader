shader_type canvas_item;

// Uniforms allow you to edit these values in the Inspector
uniform vec2 scroll_speed = vec2(1.5, -1.5); // Negative X is Left, Positive Y is Down
uniform float angle_degrees = 135.0; // Optional: adjust direction via code
uniform float alpha = 1;

void fragment() {
    // Calculate the offset based on time and speed
    // UV is the coordinate of the texture (0.0 to 1.0)
    vec2 shifted_uv = UV + (scroll_speed * TIME);
    
    // fract() ensures the value loops between 0 and 1, creating the infinite wrap
    vec4 color = texture(TEXTURE, fract(shifted_uv));
	color.a *= alpha;
    
    COLOR = color;
}