extends LargeTexture

class_name AtlasRegionArray

var identifier : String 
var index : int
var size : Vector2 = Vector2()
var location : Vector2 = Vector2()
	
func set_size(new_size:Vector2):
	size = new_size
func get_size():
	return size
func get_index():
	return index
func set_index(num:int):
	index = num
func set_location(loc:Vector2):
	location = loc
func get_location():
	return location
func set_identifier(nam:String):
	identifier = nam
func get_identifier():
	return identifier