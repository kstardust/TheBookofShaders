// https://www.flong.com/archive/texts/code/shapers_poly/index.html

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

float blinn_wyvill_cos(float x) {
    float x2 = x * x;
    float x4 = x2 * x2;
    float x6 = x4 * x2;

    return (4.0 / 9.0) * x6 - (17.0 / 9.0) * x4 + (22.0 / 9.0) * x2;
}

void main() {
    float speed = 2.0;
    float amplitude = 1.0;
    float freq = 5.0;
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    float x = abs(fract(speed * u_time + freq * st.x) - 0.5) / 0.5;
    float y = blinn_wyvill_cos(x) * amplitude;

    vec3 bg = vec3(0.2, 0.2, 0.2);

    vec3 line_color = vec3(0.0, 0.8, 0.8);
    float percent = plot_curve(st, y);
    vec3 color = bg * (1.0-percent) + line_color * (percent);
    gl_FragColor = vec4(color, 1.0);
}