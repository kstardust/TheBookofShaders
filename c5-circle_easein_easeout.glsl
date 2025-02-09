// https://www.flong.com/archive/texts/code/shapers_circ/index.html

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.1415926

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

float plot(vec2 st, float y) {
    return 1.0 - smoothstep(0.0, 0.005, abs(y-st.y));
}

float circle_ease_in(float x) {
    return 1.0 - sqrt(1.0 - x*x);
}

float circle_ease_out(float x) {
    return 1.0 - sqrt(1.0 - (1.0 - x) * (1.0 - x));
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    vec3 bg = vec3(1.0);
    bg.r = sin(st.x);
    bg.g = cos(st.x);
    bg.b = pow(st.x, 0.03);

    vec3 color = bg;
    color = mix(color, vec3(1.0, 0.0, .0), plot(st, circle_ease_out(st.x)));
    color = mix(color, vec3(.0, 1.0, .0), plot(st, circle_ease_in(st.x)));
    gl_FragColor = vec4(color, 1.0);
}
