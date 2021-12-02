//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	
	const float bloom = 0.3;
	const float range = 0.55;
	
    vec4 base_col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec3 good_numbers = vec3(0.229, 0.587, 0.114);
	
	float lum = dot(base_col.rgb, good_numbers);
	float weight = smoothstep(bloom, bloom + range, lum);
	base_col.rgb = mix(vec3(0.0), base_col.rgb, weight);
	
	gl_FragColor = base_col;
}
