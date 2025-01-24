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

float double_polynomial_sigmoid(float x, float n) {
    float y = 0.0;
    if (mod(n, 2.0) == 0.0) {
        // even
        if (x <= 0.5) {
            y = pow(2.0 * x,  n) / 2.0;
        } else {
            y = 1.0 - pow(2.0 * x - 2.0,  n) / 2.0;
        }
    } else {
        // odd
        if (x <= 0.5) {
            y = pow(2.0 * x,  n) / 2.0;
        } else {
            y = 1.0 + pow(2.0 * x - 2.0,  n) / 2.0;
        }
    }
    return y;
}

void main() {
    float speed = .25;
    float amplitude = 1.0;
    float freq = .9;
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    vec2 par = u_mouse / u_resolution;

    float y = double_polynomial_sigmoid(st.x, 3.0);
    vec3 bg = vec3(st.x, y, 1.0);

    vec3 line_color = vec3(y, st.x, 0.8);
    float percent = plot_curve(st, y);
    vec3 color = bg * (1.0-percent) + line_color * (percent);
    gl_FragColor = vec4(color, 1.0);
}