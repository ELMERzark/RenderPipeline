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

from panda3d.core import Texture, Vec4, GeomEnums, Mat4, SamplerState

from rpcore.rp_object import RPObject
from rpcore.image import Image

class ProbeManager(RPObject):
    """ Manages all environment probes """

    def __init__(self, resolution):
        """ Initializes a new probe manager """
        RPObject.__init__(self)
        self.probes = []
        self.max_probes = 64
        self.resolution = resolution
        self._create_storage()

    def _create_storage(self):
        """ Creates the cubemap storage """
        self.cubemap_storage = Image("EnvmapStorage")
        self.cubemap_storage.setup_cube_map_array(
            self.resolution, self.max_probes, Texture.T_float, Texture.F_rgba16)
        self.cubemap_storage.set_minfilter(SamplerState.FT_linear_mipmap_linear)
        self.cubemap_storage.set_magfilter(SamplerState.FT_linear)
        self.cubemap_storage.set_clear_color(Vec4(1.0, 0.0, 0.1, 1.0))
        self.cubemap_storage.clear_image()

        self.dataset_storage = Image("EnvmapData")
        self.dataset_storage.setup_buffer_texture(
            self.max_probes * 4, Texture.T_float,Texture.F_rgba32, GeomEnums.UH_dynamic)
        self.dataset_storage.set_clear_color(Vec4(0))
        self.dataset_storage.clear_image()

    def add_probe(self, probe):
        """ Adds a new probe """
        if len(self.probes) >= self.max_probes:
            self.error("Cannot attach probe, out of slots!")
            return False
        probe.index = len(self.probes)
        self.probes.append(probe)
        return True

    def update(self):
        """ Updates the manager, updating all probes """
        ptr = self.dataset_storage.modify_ram_image()
        for probe in self.probes:
            probe.write_to_buffer(ptr)

    def find_probe_to_update(self):
        """ Finds the next probe which requires an update, or returns None """
        if not self.probes:
            return None
        rating = lambda probe: probe.last_update
        return min(self.probes, key=rating)