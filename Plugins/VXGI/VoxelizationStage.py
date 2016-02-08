"""

RenderPipeline

Copyright (c) 2014-2016 tobspr <tobias.springer1@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 	 	    	 	
"""

from __future__ import division

from .. import *

from panda3d.core import Camera, OrthographicLens, NodePath, CullFaceAttrib
from panda3d.core import DepthTestAttrib, Vec4, PTALVecBase3, Vec3, Texture
from panda3d.core import PTAInt, PTAFloat, ColorWriteAttrib, SamplerState

class VoxelizationStage(RenderStage):

    """ This stage voxelizes the whole scene """

    required_inputs = []
    required_pipes = []

    # The different states of voxelization
    S_disabled = 0
    S_voxelize_x = 1
    S_voxelize_y = 2
    S_voxelize_z = 3
    S_gen_mipmaps = 4

    def __init__(self, pipeline):
        RenderStage.__init__(self, "VoxelizationStage", pipeline)
        self._voxel_res = 256
        self._voxel_ws = 20.0
        self._state = self.S_disabled
        self._create_ptas()

    def set_voxel_resolution(self, res):
        self._voxel_res = res

    def set_voxel_grid_size(self, size):
        self._voxel_ws = size

    def set_state(self, state):
        self._state = state

    def set_grid_position(self, pos):
        self._pta_next_grid_pos[0] = pos

    def _create_ptas(self):
        self._pta_next_grid_pos = PTALVecBase3.empty_array(1)
        self._pta_grid_pos = PTALVecBase3.empty_array(1)

    def get_produced_inputs(self):
        return {"voxelGridPosition": self._pta_grid_pos}

    def get_produced_pipes(self):
        return {"SceneVoxels": self._voxel_grid}

    def create(self):
        # Create the voxel grid used to generate the voxels
        self._voxel_temp_grid = Image.create_3d(
            "VoxelsTemp", self._voxel_res, self._voxel_res, self._voxel_res,
            Texture.T_float, Texture.F_rgba8)
        self._voxel_temp_grid.set_clear_color(Vec4(0))
        self._voxel_temp_nrm_grid = Image.create_3d(
            "VoxelsTemp", self._voxel_res, self._voxel_res, self._voxel_res,
            Texture.T_float, Texture.F_r11_g11_b10)
        self._voxel_temp_nrm_grid.set_clear_color(Vec4(0))

        # Create the voxel grid which is a copy of the temporary grid, but stable
        self._voxel_grid = Image.create_3d(
            "Voxels", self._voxel_res, self._voxel_res, self._voxel_res,
            Texture.T_float, Texture.F_rgba8)
        self._voxel_grid.set_clear_color(Vec4(0))
        self._voxel_grid.set_minfilter(SamplerState.FT_linear_mipmap_linear)

        # Create the camera for voxelization
        self._voxel_cam = Camera("VoxelizeCam")
        self._voxel_cam.set_camera_mask(self._pipeline.tag_mgr.get_voxelize_mask())
        self._voxel_cam_lens = OrthographicLens()
        self._voxel_cam_lens.set_film_size(-2.0 * self._voxel_ws, 2.0 * self._voxel_ws)
        self._voxel_cam_lens.set_near_far(0.0, 2.0 * self._voxel_ws)
        self._voxel_cam.set_lens(self._voxel_cam_lens)
        self._voxel_cam_np = Globals.base.render.attach_new_node(self._voxel_cam)
        self._pipeline.tag_mgr.register_voxelize_camera(self._voxel_cam)

        # Create the voxelization target
        self._voxel_target = self.make_target("VXGI:VoxelizeScene")
        self._voxel_target.set_source(source_cam=self._voxel_cam_np, source_win=Globals.base.win)
        self._voxel_target.size = self._voxel_res, self._voxel_res
        self._voxel_target.create_overlay_quad = False
        self._voxel_target.prepare_scene_render()

        # Create the target which copies the voxel grid
        self._copy_target = self.make_target("VXGI:CopyVoxels")
        self._copy_target.size = self._voxel_res, self._voxel_res
        self._copy_target.prepare_offscreen_buffer()
        self._copy_target.quad.set_instance_count(self._voxel_res)
        self._copy_target.set_shader_input("SourceTex", self._voxel_temp_grid)
        self._copy_target.set_shader_input("DestTex", self._voxel_grid)

        # Create the target which generates the mipmaps
        self._mip_targets = []
        mip_size, mip = self._voxel_res, 0
        while mip_size > 1:
            mip_size, mip = mip_size // 2, mip + 1
            mip_target = self.make_target("VXGI:GenMipmaps:" + str(mip))
            mip_target.size = mip_size
            mip_target.prepare_offscreen_buffer()
            mip_target.quad.set_instance_count(mip_size)
            mip_target.set_shader_input("SourceTex", self._voxel_grid)
            mip_target.set_shader_input("sourceMip", mip - 1)
            mip_target.set_shader_input("DestTex", self._voxel_grid,  False, True, -1, mip, 0)
            self._mip_targets.append(mip_target)

        # Create the initial state used for rendering voxels
        initial_state = NodePath("VXGIInitialState")
        initial_state.set_attrib(CullFaceAttrib.make(CullFaceAttrib.M_cull_none), 100000)
        initial_state.set_attrib(DepthTestAttrib.make(DepthTestAttrib.M_none), 100000)
        initial_state.set_attrib(ColorWriteAttrib.make(ColorWriteAttrib.C_off), 100000)
        self._voxel_cam.set_initial_state(initial_state.get_state())

        Globals.base.render.set_shader_input("voxelGridPosition", self._pta_next_grid_pos)
        Globals.base.render.set_shader_input("VoxelGridDest", self._voxel_temp_grid)

    def update(self):
        self._voxel_cam_np.show()
        self._voxel_target.set_active(True)
        self._copy_target.set_active(False)

        for target in self._mip_targets:
            target.set_active(False)

        # Voxelization disable
        if self._state == self.S_disabled:
            self._voxel_cam_np.hide()
            self._voxel_target.set_active(False)

        # Voxelization from X-Axis
        elif self._state == self.S_voxelize_x:
            # Clear voxel grid
            self._voxel_temp_grid.clear_image()
            self._voxel_cam_np.set_pos(self._pta_next_grid_pos[0] + Vec3(self._voxel_ws, 0, 0))
            self._voxel_cam_np.look_at(self._pta_next_grid_pos[0])

        # Voxelization from Y-Axis
        elif self._state == self.S_voxelize_y:
            self._voxel_cam_np.set_pos(self._pta_next_grid_pos[0] + Vec3(0, self._voxel_ws, 0))
            self._voxel_cam_np.look_at(self._pta_next_grid_pos[0])

        # Voxelization from Z-Axis
        elif self._state == self.S_voxelize_z:
            self._voxel_cam_np.set_pos(self._pta_next_grid_pos[0] + Vec3(0, 0, self._voxel_ws))
            self._voxel_cam_np.look_at(self._pta_next_grid_pos[0])

        # Generate mipmaps
        elif self._state == self.S_gen_mipmaps:
            self._voxel_target.set_active(False)
            self._copy_target.set_active(True)
            self._voxel_cam_np.hide()

            for target in self._mip_targets:
                target.set_active(True)

            # As soon as we generate the mipmaps, we need to update the grid position
            # as well
            self._pta_grid_pos[0] = self._pta_next_grid_pos[0]

    def set_shaders(self):
        self._copy_target.set_shader(
            self.load_plugin_shader("Shader/DefaultPostProcessInstanced.vert",
                                     "CopyVoxels.frag"))
        mip_shader = self.load_plugin_shader(
            "Shader/DefaultPostProcessInstanced.vert", "GenerateMipmaps.frag")
        for target in self._mip_targets:
            target.set_shader(mip_shader)

    def set_shader_input(self, *args):
        Globals.render.set_shader_input(*args)