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

void main() {

    vec2 st = gl_FragCoord.xy / u_resolution;

    vec3 per = vec3(st.x);
    per.r = smoothstep(0.0, 1.0, st.x);
    per.g = sin(st.x * PI);
    per.b = pow(st.x, 0.5);

    vec3 color = mix(colorA, colorB, per);

    // draw the lines
    color = mix(color, vec3(1.0, 0.0, 0.0), plot(st, per.r));
    color = mix(color, vec3(0.0, 1.0, 0.0), plot(st, per.g));
    color = mix(color, vec3(0.0, 0.0, 1.0), plot(st, per.b));

    gl_FragColor = vec4(color, 1.0);
}