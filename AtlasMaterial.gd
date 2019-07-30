extends SpatialMaterial
var Sectors = []
var Size
export(Array, Rect2) var Regions 
signal material_ready
class AtlasRegion:
	extends Object
	var identifier : String 
	var index : int
	var rect: Rect2
	func _init(idx:int, in_rect:Rect2, nam:String):
		index = idx
		set_identifier(nam)
		rect = in_rect
	func set_size(new_size:Vector2):
		rect.size = new_size
	func get_size():
		return rect.size
	func get_index():
		return index
	func set_index(num:int):
		index = num
	func set_location(loc:Vector2):
		rect.position = loc
	func get_location():
		return rect.position
	func set_identifier(nam:String):
		identifier = nam
	func get_identifier():
		return identifier
		
func get_region(index):
	return Sectors[index]
func add_region(region):
	pass
func delete_region():
	pass
func add_texture(index:int, texture:Texture):
	pass

func is_valid_region(rect:Rect2):
	return not rect.has_no_area()
	
func start():
	print("Here")
	Size = self.albedo_texture.get_size()
	var ARegion
	for index in range(0,Regions.size()):
		if is_valid_region(Regions[index]):
			ARegion = AtlasRegion.new(index, Regions[index], "None")
			Sectors.append(ARegion)
	emit_signal("material_ready")
	