extends NavigationRegion3D


func _ready() -> void:
	var rebake_timer = get_tree().create_timer(1)
	rebake_timer.timeout.connect(_rebake_nav_mesh)


func _rebake_nav_mesh() -> void:
	var geo_data = NavigationMeshSourceGeometryData3D.new()
	var new_nav_mesh: NavigationMesh = navigation_mesh
	NavigationMeshGenerator.parse_source_geometry_data(new_nav_mesh, geo_data, self, _on_parse_complete.bind(new_nav_mesh, geo_data))


func _on_parse_complete(mesh:NavigationMesh, data:NavigationMeshSourceGeometryData3D) -> void:
	NavigationMeshGenerator.bake_from_source_geometry_data(mesh, data, _on_bake_complete.bind(mesh))


func _on_bake_complete(mesh:NavigationMesh) -> void:
	navigation_mesh = null
	navigation_mesh = mesh
