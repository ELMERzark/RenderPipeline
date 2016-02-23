/**
 *
 * RenderPipeline
 *
 * Copyright (c) 2014-2016 tobspr <tobias.springer1@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#version 420

#define USE_MAIN_SCENE_DATA
#define USE_TIME_OF_DAY
#pragma include "render_pipeline_base.inc.glsl"
#pragma include "includes/tonemapping.inc.glsl"

uniform sampler2D ShadedScene;
uniform sampler3D ColorLUT;

out vec4 result;

// Color LUT
vec3 apply_lut(vec3 color) {
    vec3 lut_coord = color;

    // We have a gradient from 0.5 / lut_size to 1 - 0.5 / lut_size
    // need to transform from 0 .. 1 to that gradient:
    float lut_start = 0.5 / 64.0;
    float lut_end = 1.0 - lut_start;
    lut_coord = lut_coord * (lut_end - lut_start) + lut_start;
    return textureLod(ColorLUT, lut_coord, 0).xyz;
}

void main() {

    vec2 texcoord = get_texcoord();

    #if !DEBUG_MODE

        vec3 scene_color = textureLod(ShadedScene, texcoord, 0).xyz;

        // Downscale the color in case we don't use automatic exposure, to simulate
        // the dynamic range.
        #if !GET_SETTING(color_correction, use_auto_exposure)
            scene_color *= 0.1;
        #endif

        // Apply tonemapping
        scene_color = do_tonemapping(scene_color);

        // Apply the LUT
        scene_color = apply_lut(scene_color);

    #else
        vec3 scene_color = textureLod(ShadedScene, texcoord, 0).xyz;
    #endif // !DEBUG_MODE

    result = vec4(scene_color, 1);
}