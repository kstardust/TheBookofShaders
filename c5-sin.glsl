#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.1415926

uniform vec2 u_mouse;
uniform float u_time;
uniform vec2 u_resolution;

float plot_curve(vec2 coord, float pct) {
    return 1.0-smoothstep(0.0, 0.02, abs(coord.y-pct));
}

void main() {
    float speed = 2.0;
    float amplitude = 0.45;
    float freq = 2.0 * PI;
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    float y = sin(freq*st.x+u_time*speed) * amplitude + 0.5;
    vec3 bg = vec3(0.2, 0.2, 0.2);

    vec3 line_color = vec3(0.0, 0.8, 0.8);
    float percent = plot_curve(st, y);
    vec3 color = bg * (1.0-percent) + line_color * (percent);
    gl_FragColor = vec4(color, 1.0);
}
