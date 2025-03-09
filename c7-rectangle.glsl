#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

float smooth_rect(vec2 st, float border_w) {
    vec2 lb = smoothstep(0.0, border_w, st);
    vec2 tr = smoothstep(0.0, border_w, 1.0-st);
    return lb.x * lb.y * tr.x * tr.y;
}

float floor_rect(vec2 st, float border_w) {
    vec2 lb = floor(st+(1.0-border_w));
    vec2 tr = floor(st-(1.0-border_w));
    return lb.x * lb.y * tr.x * tr.y;
}

float step_rect(vec2 st, vec2 size, vec2 bottom_left) {
    vec2 lb = step(bottom_left, st);
    vec2 tr = step(1.0-bottom_left - size, 1.0-st);
    return lb.x * lb.y * tr.x * tr.y;
}

float rect_nofill(vec2 st, vec2 size, vec2 bottom_left,
            float border_w) {
    float r = step_rect(st, size, bottom_left);
    r *= 1.0-step_rect(st, size-2.0*border_w, bottom_left+border_w);
    return r;
}

float rect_smooth_nofill(vec2 st, vec2 size, vec2 bottom_left,
            float border_w) {
    float r = step_rect(st, size, bottom_left);
    r *= 1.0-step_rect(st, size-2.0*border_w, bottom_left+border_w);
    return r;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    vec3 color = vec3(rect_nofill(st, vec2(0.8, 0.4), vec2(0.2, 0.1), 0.02));
    color += vec3(rect_nofill(st, vec2(0.6, 0.9), vec2(0.3, 0.3), 0.01));
    gl_FragColor = vec4(color, 1.0);
}