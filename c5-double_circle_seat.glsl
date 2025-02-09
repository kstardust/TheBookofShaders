// https://www.flong.com/archive/texts/code/shapers_circ/index.html

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.1415926

uniform vec2 u_resolution;
uniform float u_time;

float plot(vec2 st, float y) {
    return 1.0 - smoothstep(0.0, 0.005, abs(y-st.y));
}

float double_circle_seat(float a, float x) {
    a = clamp(a, 0.0, 1.0);
    if (x <= a) {
        return sqrt(a*a - (x-a)*(x-a));
    } else {
        return 1.0 - sqrt((1.0-a)*(1.0-a) - (x-a)*(x-a));
    }
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    vec3 bg = vec3(1.0);
    bg.r = sin(st.x);
    bg.g = cos(st.x);
    bg.b = pow(st.x, 0.03);

    vec3 color = bg;
    color = mix(color, vec3(1.0, 0.0, .0), plot(st, double_circle_seat(0.2, st.x)));
    color = mix(color, vec3(0.0, 1.0, .0), plot(st, double_circle_seat(0.8, st.x)));
    color = mix(color, vec3(1.0, 1.0, .0), plot(st, double_circle_seat(0.5, st.x)));
    gl_FragColor = vec4(color, 1.0);
}
