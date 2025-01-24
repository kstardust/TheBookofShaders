#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.1415926

uniform vec2 u_resolution;
uniform float u_time;

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix( vec3(1.0), rgb, c.y);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec2 ct = 0.5 - st;

    // convert to polar coordination
    float a = fract(atan(ct.y, ct.x) / (2.0*PI) -u_time);
    float r = 2.0*length(ct.xy);
    if (r > 1.0)
        r = 0.0;
    vec3 color = hsb2rgb(vec3(a, r, 1.0));
    gl_FragColor = vec4(color, 1.0);
}