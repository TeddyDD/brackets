/*
  ______________________________
 / Play apropriate music firts! \
 \ https://youtu.be/fpmTe3TDdVU /
  ------------------------------
  \
   \
    \ >()_
       (__)__ _


You can run it in online editor: https://thebookofshaders.com/edit.php
*/

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TAU 6.28318530718

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// vertices
uniform int N;
// Size (relative to screen size)
uniform float Size;

mat2 rotate(float angle){
    return mat2(cos(angle),sin(angle),
                -sin(angle),cos(angle));
}

float ngon(int N, float size, in vec2 st) {
    float a = atan(st.x,st.y)+PI;
    float r = TAU/float(N);
    return cos(floor(.5+a/r)*r-a)*((length(st)) / size);
}

float line(in vec2 st, in vec2 size){
    size = vec2(0.5) - size;
    vec2 uv = smoothstep(size, size+vec2(0.001), st);
    uv *= smoothstep(size, size+vec2(0.001), vec2(1.0)-st);
    return uv.x*uv.y;
}

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st.x *= u_resolution.x/u_resolution.y;
  vec3 color = vec3(0.0);
  float d = 0.0;

  // Remap the space to -1. to 1 and rotate
  st = st *2.-1.;
  st = rotate(u_time) * st;

  if (N == 3) {
      float h = (Size / 3.) * 2.; // yeah a bit hacky
      d = ngon(N, h, st);
  } else if (N > 2) {
      d = ngon(N, Size, st);
  } else {
      d =  1.0 - line(st + vec2(.5,.5), vec2(Size,0.02));
  }

  // 0.98 gives nice smooth edges
  color = vec3(1.0-smoothstep(.98,1.00,d));

  gl_FragColor = vec4(color,1.0);
}
