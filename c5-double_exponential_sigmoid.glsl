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

float double_exponential_sigmoid(float x, float a) {
    float epsilon = 0.00001;
    a = clamp(0.0+epsilon, 1.0+epsilon, a);

    float y = 0.0;
    if (x <= 0.5) {
        y = (pow(2.0*x, 1.0/a)) / 2.0;
    } else {
        y = 1.0 - pow(2.0 *(1.0-x), 1.0/a)/2.0;
    }

    return y;
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
                plot(st, double_exponential_sigmoid(st.x, 0.1)));
    color = mix(color, vec3(0.0, 1.0, 0.0),
                plot(st, double_exponential_sigmoid(st.x, 0.7)));
    color = mix(color, vec3(1.0, 0.0, 0.0),
                plot(st, double_exponential_sigmoid(st.x, abs(sin(u_time)))));

    gl_FragColor = vec4(color, 1.0);
}