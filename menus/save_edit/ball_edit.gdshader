shader_type canvas_item;


uniform sampler2D gradient_texture;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(gradient_texture, UV);
	
	if (
		UV.x / 4.0 + UV.y / 2.0 > 0.5 
		||
		UV.x * 2.0 - UV.y * 4.0 > 0.0
	) {
		COLOR.a = 0.0;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
