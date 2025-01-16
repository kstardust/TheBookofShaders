#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_mouse;
uniform float u_time;
uniform vec2 u_resolution;

float plot_x(vec2 st) {
    float a = 1.0-smoothstep(0.0, 0.02, abs(1.0-st.x-st.y));
    float b = 1.0-smoothstep(0.0, 0.02, abs(st.x-st.y));
    return max(a,b);
}

float plot_curve(vec2 st, float per) {
  return 1.0-smoothstep(0.0, 0.02, abs(st.y-per));
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    float y = fract(sin(st.x));
    vec3 bg = vec3(y);

    vec3 line_color = vec3(0.0, 1.0, 0.0);
    float percent = plot_curve(st, y);
    vec3 color = bg * (1.0-percent) + line_color * (percent);
    gl_FragColor = vec4(color, 1.0);
}
