#pragma once



vec2 poisson_disk_2D_16[16] = vec2[](
    vec2( -0.195090322016 , -0.980785280403 ),
    vec2( 0.55557023302 , 0.831469612303 ),
    vec2( -0.831469612303 , -0.55557023302 ),
    vec2( 0.980785280403 , 0.195090322016 ),
    vec2( -0.980785280403 , 0.195090322016 ),
    vec2( 0.831469612303 , -0.55557023302 ),
    vec2( -0.55557023302 , 0.831469612303 ),
    vec2( 0.195090322016 , -0.980785280403 ),
    vec2( 0.195090322016 , 0.980785280403 ),
    vec2( -0.55557023302 , -0.831469612303 ),
    vec2( 0.831469612303 , 0.55557023302 ),
    vec2( -0.980785280403 , -0.195090322016 ),
    vec2( 0.980785280403 , -0.195090322016 ),
    vec2( -0.831469612303 , 0.55557023302 ),
    vec2( 0.55557023302 , -0.831469612303 ),
    vec2( -0.195090322016 , 0.980785280403 )
);


vec2 poisson_disk_2D_32[32] = vec2[](
    vec2( -0.634393284164 , 0.773010453363 ),
    vec2( 0.881921264348 , 0.471396736826 ),
    vec2( 0.290284677254 , -0.956940335732 ),
    vec2( -0.995184726672 , -0.0980171403296 ),
    vec2( 0.0980171403296 , 0.995184726672 ),
    vec2( 0.956940335732 , -0.290284677254 ),
    vec2( -0.471396736826 , -0.881921264348 ),
    vec2( -0.773010453363 , 0.634393284164 ),
    vec2( 0.773010453363 , 0.634393284164 ),
    vec2( 0.471396736826 , -0.881921264348 ),
    vec2( -0.956940335732 , -0.290284677254 ),
    vec2( -0.0980171403296 , 0.995184726672 ),
    vec2( 0.995184726672 , -0.0980171403296 ),
    vec2( -0.290284677254 , -0.956940335732 ),
    vec2( -0.881921264348 , 0.471396736826 ),
    vec2( 0.634393284164 , 0.773010453363 ),
    vec2( 0.634393284164 , -0.773010453363 ),
    vec2( -0.881921264348 , -0.471396736826 ),
    vec2( -0.290284677254 , 0.956940335732 ),
    vec2( 0.995184726672 , 0.0980171403296 ),
    vec2( -0.0980171403296 , -0.995184726672 ),
    vec2( -0.956940335732 , 0.290284677254 ),
    vec2( 0.471396736826 , 0.881921264348 ),
    vec2( 0.773010453363 , -0.634393284164 ),
    vec2( -0.773010453363 , -0.634393284164 ),
    vec2( -0.471396736826 , 0.881921264348 ),
    vec2( 0.956940335732 , 0.290284677254 ),
    vec2( 0.0980171403296 , -0.995184726672 ),
    vec2( -0.995184726672 , 0.0980171403296 ),
    vec2( 0.290284677254 , 0.956940335732 ),
    vec2( 0.881921264348 , -0.471396736826 ),
    vec2( -0.634393284164 , -0.773010453363 )
);


vec2 poisson_disk_2D_128[128] = vec2[](
    vec2( 0.84485356525 , 0.534997619887 ),
    vec2( -0.122410675199 , 0.992479534599 ),
    vec2( -0.949528180593 , 0.313681740399 ),
    vec2( -0.689540544737 , -0.724247082951 ),
    vec2( 0.359895036535 , -0.932992798835 ),
    vec2( 0.997290456679 , -0.0735645635997 ),
    vec2( 0.49289819223 , 0.870086991109 ),
    vec2( -0.575808191418 , 0.817584813152 ),
    vec2( -0.985277642389 , -0.17096188876 ),
    vec2( -0.266712757475 , -0.963776065795 ),
    vec2( 0.757208846506 , -0.653172842954 ),
    vec2( 0.914209755704 , 0.405241314005 ),
    vec2( 0.0245412285229 , 0.999698818696 ),
    vec2( -0.893224301196 , 0.449611329655 ),
    vec2( -0.788346427627 , -0.615231590581 ),
    vec2( 0.219101240157 , -0.975702130039 ),
    vec2( 0.975702130039 , -0.219101240157 ),
    vec2( 0.615231590581 , 0.788346427627 ),
    vec2( -0.449611329655 , 0.893224301196 ),
    vec2( -0.999698818696 , -0.0245412285229 ),
    vec2( -0.405241314005 , -0.914209755704 ),
    vec2( 0.653172842954 , -0.757208846506 ),
    vec2( 0.963776065795 , 0.266712757475 ),
    vec2( 0.17096188876 , 0.985277642389 ),
    vec2( -0.817584813152 , 0.575808191418 ),
    vec2( -0.870086991109 , -0.49289819223 ),
    vec2( 0.0735645635997 , -0.997290456679 ),
    vec2( 0.932992798835 , -0.359895036535 ),
    vec2( 0.724247082951 , 0.689540544737 ),
    vec2( -0.313681740399 , 0.949528180593 ),
    vec2( -0.992479534599 , 0.122410675199 ),
    vec2( -0.534997619887 , -0.84485356525 ),
    vec2( 0.534997619887 , -0.84485356525 ),
    vec2( 0.992479534599 , 0.122410675199 ),
    vec2( 0.313681740399 , 0.949528180593 ),
    vec2( -0.724247082951 , 0.689540544737 ),
    vec2( -0.932992798835 , -0.359895036535 ),
    vec2( -0.0735645635997 , -0.997290456679 ),
    vec2( 0.870086991109 , -0.49289819223 ),
    vec2( 0.817584813152 , 0.575808191418 ),
    vec2( -0.17096188876 , 0.985277642389 ),
    vec2( -0.963776065795 , 0.266712757475 ),
    vec2( -0.653172842954 , -0.757208846506 ),
    vec2( 0.405241314005 , -0.914209755704 ),
    vec2( 0.999698818696 , -0.0245412285229 ),
    vec2( 0.449611329655 , 0.893224301196 ),
    vec2( -0.615231590581 , 0.788346427627 ),
    vec2( -0.975702130039 , -0.219101240157 ),
    vec2( -0.219101240157 , -0.975702130039 ),
    vec2( 0.788346427627 , -0.615231590581 ),
    vec2( 0.893224301196 , 0.449611329655 ),
    vec2( -0.0245412285229 , 0.999698818696 ),
    vec2( -0.914209755704 , 0.405241314005 ),
    vec2( -0.757208846506 , -0.653172842954 ),
    vec2( 0.266712757475 , -0.963776065795 ),
    vec2( 0.985277642389 , -0.17096188876 ),
    vec2( 0.575808191418 , 0.817584813152 ),
    vec2( -0.49289819223 , 0.870086991109 ),
    vec2( -0.997290456679 , -0.0735645635997 ),
    vec2( -0.359895036535 , -0.932992798835 ),
    vec2( 0.689540544737 , -0.724247082951 ),
    vec2( 0.949528180593 , 0.313681740399 ),
    vec2( 0.122410675199 , 0.992479534599 ),
    vec2( -0.84485356525 , 0.534997619887 ),
    vec2( -0.84485356525 , -0.534997619887 ),
    vec2( 0.122410675199 , -0.992479534599 ),
    vec2( 0.949528180593 , -0.313681740399 ),
    vec2( 0.689540544737 , 0.724247082951 ),
    vec2( -0.359895036535 , 0.932992798835 ),
    vec2( -0.997290456679 , 0.0735645635997 ),
    vec2( -0.49289819223 , -0.870086991109 ),
    vec2( 0.575808191418 , -0.817584813152 ),
    vec2( 0.985277642389 , 0.17096188876 ),
    vec2( 0.266712757475 , 0.963776065795 ),
    vec2( -0.757208846506 , 0.653172842954 ),
    vec2( -0.914209755704 , -0.405241314005 ),
    vec2( -0.0245412285229 , -0.999698818696 ),
    vec2( 0.893224301196 , -0.449611329655 ),
    vec2( 0.788346427627 , 0.615231590581 ),
    vec2( -0.219101240157 , 0.975702130039 ),
    vec2( -0.975702130039 , 0.219101240157 ),
    vec2( -0.615231590581 , -0.788346427627 ),
    vec2( 0.449611329655 , -0.893224301196 ),
    vec2( 0.999698818696 , 0.0245412285229 ),
    vec2( 0.405241314005 , 0.914209755704 ),
    vec2( -0.653172842954 , 0.757208846506 ),
    vec2( -0.963776065795 , -0.266712757475 ),
    vec2( -0.17096188876 , -0.985277642389 ),
    vec2( 0.817584813152 , -0.575808191418 ),
    vec2( 0.870086991109 , 0.49289819223 ),
    vec2( -0.0735645635997 , 0.997290456679 ),
    vec2( -0.932992798835 , 0.359895036535 ),
    vec2( -0.724247082951 , -0.689540544737 ),
    vec2( 0.313681740399 , -0.949528180593 ),
    vec2( 0.992479534599 , -0.122410675199 ),
    vec2( 0.534997619887 , 0.84485356525 ),
    vec2( -0.534997619887 , 0.84485356525 ),
    vec2( -0.992479534599 , -0.122410675199 ),
    vec2( -0.313681740399 , -0.949528180593 ),
    vec2( 0.724247082951 , -0.689540544737 ),
    vec2( 0.932992798835 , 0.359895036535 ),
    vec2( 0.0735645635997 , 0.997290456679 ),
    vec2( -0.870086991109 , 0.49289819223 ),
    vec2( -0.817584813152 , -0.575808191418 ),
    vec2( 0.17096188876 , -0.985277642389 ),
    vec2( 0.963776065795 , -0.266712757475 ),
    vec2( 0.653172842954 , 0.757208846506 ),
    vec2( -0.405241314005 , 0.914209755704 ),
    vec2( -0.999698818696 , 0.0245412285229 ),
    vec2( -0.449611329655 , -0.893224301196 ),
    vec2( 0.615231590581 , -0.788346427627 ),
    vec2( 0.975702130039 , 0.219101240157 ),
    vec2( 0.219101240157 , 0.975702130039 ),
    vec2( -0.788346427627 , 0.615231590581 ),
    vec2( -0.893224301196 , -0.449611329655 ),
    vec2( 0.0245412285229 , -0.999698818696 ),
    vec2( 0.914209755704 , -0.405241314005 ),
    vec2( 0.757208846506 , 0.653172842954 ),
    vec2( -0.266712757475 , 0.963776065795 ),
    vec2( -0.985277642389 , 0.17096188876 ),
    vec2( -0.575808191418 , -0.817584813152 ),
    vec2( 0.49289819223 , -0.870086991109 ),
    vec2( 0.997290456679 , 0.0735645635997 ),
    vec2( 0.359895036535 , 0.932992798835 ),
    vec2( -0.689540544737 , 0.724247082951 ),
    vec2( -0.949528180593 , -0.313681740399 ),
    vec2( -0.122410675199 , -0.992479534599 ),
    vec2( 0.84485356525 , -0.534997619887 )
);




vec3 poisson_disk_3D_32[32] = vec3[](
    vec3(-0.134, 0.044, -0.825),
    vec3(0.045, -0.431, -0.529),
    vec3(-0.537, 0.195, -0.371),
    vec3(0.525, -0.397, 0.713),
    vec3(0.895, 0.302, 0.139),
    vec3(-0.613, -0.408, -0.141),
    vec3(0.307, 0.822, 0.169),
    vec3(-0.819, 0.037, -0.388),
    vec3(0.376, 0.009, 0.193),
    vec3(-0.006, -0.103, -0.035),
    vec3(0.098, 0.393, 0.019),
    vec3(0.542, -0.218, -0.593),
    vec3(0.526, -0.183, 0.424),
    vec3(-0.529, -0.178, 0.684),
    vec3(0.066, -0.657, -0.570),
    vec3(-0.214, 0.288, 0.188),
    vec3(-0.689, -0.222, -0.192),
    vec3(-0.008, -0.212, -0.721),
    vec3(0.053, -0.863, 0.054),
    vec3(0.639, -0.558, 0.289),
    vec3(-0.255, 0.958, 0.099),
    vec3(-0.488, 0.473, -0.381),
    vec3(-0.592, -0.332, 0.137),
    vec3(0.080, 0.756, -0.494),
    vec3(-0.638, 0.319, 0.686),
    vec3(-0.663, 0.230, -0.634),
    vec3(0.235, -0.547, 0.664),
    vec3(0.164, -0.710, 0.086),
    vec3(-0.009, 0.493, -0.038),
    vec3(-0.322, 0.147, -0.105),
    vec3(-0.554, -0.725, 0.289),
    vec3(0.534, 0.157, -0.250)
);
