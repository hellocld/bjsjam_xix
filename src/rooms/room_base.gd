class_name RoomBase
extends Node3D

@onready var nav_region:NavigationRegion3D = $NavigationRegion3D
@onready var navigator:Navigator = $Navigator
@onready var nav_start:Node3D = $NavigatorStart
@onready var nav_goal:Node3D = $NavigatorGoal

func _ready() -> void:
	navigator.configure(nav_start, nav_goal)


func rebake_room_navigation() -> void:
	var geo_data = NavigationMeshSourceGeometryData3D.new()
	var new_nav_mesh: NavigationMesh = nav_region.navigation_mesh
	NavigationMeshGenerator.parse_source_geometry_data(new_nav_mesh, geo_data, self, _on_parse_complete.bind(new_nav_mesh, geo_data))


func _on_parse_complete(mesh:NavigationMesh, data:NavigationMeshSourceGeometryData3D) -> void:
	NavigationMeshGenerator.bake_from_source_geometry_data(mesh, data, _on_bake_complete.bind(mesh))


func _on_bake_complete(mesh:NavigationMesh) -> void:
	nav_region.navigation_mesh = null
	nav_region.navigation_mesh = mesh
	EventBus.map_baked.emit()
