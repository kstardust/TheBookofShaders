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

float double_cubic_seat(float x, float a, float b) {
    float epislon = 0.00001;
    a = clamp(0.0 + epislon, 1.0 - epislon, a);
    b = clamp(0.0, 1.0, b);

    float y = 0.0;
    if (x <= a) {
        y = b - b * pow(1.0 - x/a, 3.0);
    } else {
        y = b + (1.0 - b) * pow((x-a)/(1.0-a), 3.0);
    }
    return y;
}

float double_cubic_seat_with_linear_blend(float x, float a, float b) {
    float epislon = 0.00001;
    a = clamp(0.0 + epislon, 1.0 - epislon, a);
    b = clamp(0.0, 1.0, b);

    float y = 0.0;
    if (x <= a) {
        y = b * x + (1.0 - b) * a * (1.0 - pow(1.0-x/a, 3.0));
    } else {
        y = b * x + (1.0 - b) * (a + (1.0 - a) * pow((x-a)/(1.0-a), 3.0));
    }
    return y;
}

void main() {
    float speed = .25;
    float amplitude = 1.0;
    float freq = .9;
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    //float x = abs(fract(speed * u_time + freq * st.x) - 0.5) / 0.5;
    //float y = blinn_wyvill_cos(x) * amplitude;
    vec2 par = u_mouse / u_resolution;

    float y = double_cubic_seat_with_linear_blend(st.x, par.x, par.y);
    vec3 bg = vec3(st.x, y, 1.0);

    vec3 line_color = vec3(y, st.x, 0.8);
    float percent = plot_curve(st, y);
    vec3 color = bg * (1.0-percent) + line_color * (percent);
    gl_FragColor = vec4(color, 1.0);
}