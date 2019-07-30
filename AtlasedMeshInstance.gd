tool
extends MeshInstance
class_name AtlasedMeshInstance
var original_mesh
export(int) var material_region_index

func _ready():
	get_surface_material(0).connect("material_ready", self, "_on_material_ready")
	get_surface_material(0).start()

func _on_material_ready():
	var AtlasSize = get_surface_material(0).Size
	var RegionSize = get_surface_material(0).get_region(material_region_index).get_size()
	var uv_scale = RegionSize/AtlasSize
	var uv_offset = get_surface_material(0).get_region(material_region_index).get_location()
	original_mesh = self.mesh
	var primitive_type = Mesh.PRIMITIVE_TRIANGLES
	var arrays = []
	var new_mesh : ArrayMesh = ArrayMesh.new()
	
	for numbers in original_mesh.get_surface_count():
		arrays = original_mesh.surface_get_arrays(numbers)
		print(arrays[Mesh.ARRAY_TEX_UV]);
		for index in arrays[Mesh.ARRAY_TEX_UV].size():
			arrays[Mesh.ARRAY_TEX_UV][index] = arrays[Mesh.ARRAY_TEX_UV][index]*uv_scale+uv_offset
		print(arrays[Mesh.ARRAY_TEX_UV]);
		if original_mesh is ArrayMesh:
			original_mesh.surface_get_primitive_type()
		new_mesh.add_surface_from_arrays(primitive_type, arrays, original_mesh.surface_get_blend_shape_arrays(numbers))
		arrays = []
	self.mesh = new_mesh
	pass