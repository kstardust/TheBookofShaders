// https://www.flong.com/archive/texts/code/shapers_exp/index.html

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.1415926

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

float plot(vec2 st, float y) {
    return 1.0-smoothstep(0.0, 0.005, abs(st.y-y));
}

/*
why is it called exponential while it is using power function?
*/
float exp_ease_out(float x, float a) {
    float epislon = 0.00001;
    a = clamp(a, 0.0 + epislon, 1.0 - epislon);

    return pow(x, a);
}

float exp_ease_in(float x, float a) {
    float epislon = 0.00001;
    a = clamp(a, 0.0 + epislon, 1.0 - epislon);

    return pow(x, 1.0/a);
}

void main() {

    vec2 st = gl_FragCoord.xy / u_resolution;

    vec3 per = vec3(st.x);
    per.r = smoothstep(0.0, 1.0, st.x);
    per.g = sin(st.x * PI);
    per.b = pow(st.x, 0.5);

    vec3 color = mix(colorA, colorB, per);

    // draw the lines
    color = mix(color, vec3(1.0, 1.0, 0.0),
                plot(st, exp_ease_in(st.x, 0.5)));
    color = mix(color, vec3(0.0, 1.0, 0.0),
                plot(st, exp_ease_out(st.x, 0.5)));

    gl_FragColor = vec4(color, 1.0);
}