extends MeshInstance
class_name AtlasedMeshInstance
export(int) var material_region_index

#For use with non-tiling textures only!

func _ready():
	get_surface_material(0).connect("material_ready", self, "_on_material_ready")
	get_surface_material(0).start()

func _on_material_ready():
	update_material()

func update_material():
	if not mesh is ArrayMesh:
		print("Error! This tool must be used with an Array Mesh")
		return
	var AtlasSize = get_surface_material(0).Size
	var RegionSize = get_surface_material(0).get_region(material_region_index).get_size()
	var uv_scale = RegionSize/AtlasSize
	var uv_offset = get_surface_material(0).get_region(material_region_index).get_location()
	uv_offset = uv_offset/AtlasSize

	var primitive_type = Mesh.PRIMITIVE_TRIANGLES
	var arrays = []
	
	for numbers in mesh.get_surface_count():
		arrays = mesh.surface_get_arrays(numbers)
		print(arrays[Mesh.ARRAY_TEX_UV]);
		for index in arrays[Mesh.ARRAY_TEX_UV].size():
			arrays[Mesh.ARRAY_TEX_UV][index] = arrays[Mesh.ARRAY_TEX_UV][index]*uv_scale+uv_offset
		print(arrays[Mesh.ARRAY_TEX_UV]);
		var blend_shape_arrays = mesh.surface_get_blend_shape_arrays(numbers)
		#Remove the old surface and add the new one
		mesh.surface_get_primitive_type(numbers)
		mesh.surface_remove(numbers)
		mesh.add_surface_from_arrays(primitive_type, arrays, blend_shape_arrays)
		
		arrays = []

