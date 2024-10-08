shader_type canvas_item;

uniform vec4 color_inner : source_color = vec4(0.2, 0.7, 0.9, 1.0);
uniform vec4 color_outer : source_color = vec4(1.0, 0.0, 1.0, 1.0);
uniform float inner_radius : hint_range(0.0, 1.0) = 0.6;
uniform float outer_radius : hint_range(0.0, 1.0) = 0.9;
uniform float edge_softness : hint_range(0.0, 0.1) = 0.05;
uniform float flow_speed : hint_range(0.0, 2.0) = 0.5;
uniform float distortion_strength : hint_range(0.0, 0.2) = 0.1;
uniform float goo_frequency : hint_range(1.0, 10.0) = 3.0;
uniform float time_scale : hint_range(0.1, 2.0) = 1.0;
uniform float surface_tension : hint_range(0.0, 1.0) = 0.7;
uniform sampler2D noise_texture : hint_default_white;

vec2 rotate(vec2 p, float a) {
    float c = cos(a);
    float s = sin(a);
    return p * mat2(vec2(c, -s), vec2(s, c));
}

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 flow_distortion(vec2 uv, float time) {
    vec2 noise1 = texture(noise_texture, uv + time * 0.1).rg * 2.0 - 1.0;
    vec2 noise2 = texture(noise_texture, uv * 1.5 - time * 0.15).rg * 2.0 - 1.0;
    return noise1 * 0.5 + noise2 * 0.5;
}

float goo_pattern(vec2 uv, float time) {
    float pattern = sin(uv.x * goo_frequency + time) * cos(uv.y * goo_frequency + time);
    pattern = smoothstep(-1.0, 1.0, pattern);
    return mix(pattern, 0.5, surface_tension);
}

void fragment() {
    vec2 uv = UV * 2.0 - 1.0;
    float dist = length(uv);
    
    // Apply gooey distortion
    float time = TIME * time_scale;
    vec2 flow = flow_distortion(uv, time);
    uv += flow * distortion_strength;
    dist = length(uv);
    
    // Create goo pattern
    float goo = goo_pattern(uv, time);
    dist += goo * distortion_strength;
    
    // Create the orb shape with soft edges
    float circle = smoothstep(outer_radius + edge_softness, outer_radius - edge_softness, dist);
    
    // Mix colors based on distance and goo pattern
    vec4 color = mix(color_outer, color_inner, smoothstep(outer_radius, inner_radius, dist));
    color = mix(color, color_inner, goo * 0.5);
    
    // Add some sparkle
    float sparkle = random(uv * 50.0 + time);
    sparkle = pow(sparkle, 20.0);
    color.rgb += vec3(sparkle) * 0.2;
    
    // Apply final color and alpha
    COLOR = color * circle;
    COLOR.a *= circle;
    
    // Add glow effect
    COLOR.rgb += smoothstep(0.5, 0.0, dist) * 0.2;
    
    // Add shimmering edge effect
    float edge = smoothstep(outer_radius - 0.05, outer_radius, dist) - 
                 smoothstep(outer_radius, outer_radius + 0.05, dist);
    COLOR.rgb += edge * mix(color_outer.rgb, color_inner.rgb, sin(time * 2.0) * 0.5 + 0.5);
}