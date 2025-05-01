class_name Cube
extends Node

var cube:Array

func _init(cubeInfo:Dictionary,workPath:String) -> void:
	var from:Array=cubeInfo[Constant.CUBE_FROM]
	var to:Array=cubeInfo[Constant.CUBE_TO]
	for i in range(0,8):#始点/終点の情報から直方体の頂点を割り出す
		var x:int
		var y:int
		var z:int
		match i:
			0,2,4,6:
				x=from[0]
			1,3,5,7:
				x=to[0]
		match i:
			0,1,4,5:
				y=from[1]
			2,3,6,7:
				y=to[1]
		match i:
			0,1,2,3:
				z=from[2]
			4,5,6,7:
				z=to[2]
		cube.append(Vector3(x,y,z)/Constant.BLOCK_PIXEL)
	make_mesh(cube,cubeInfo,workPath)

func make_mesh(cubePoint:Array,cubeInfo:Dictionary,workPath:String):
	var faces:Array
	for key in [Constant.UP,Constant.DOWN,Constant.NORTH,Constant.EAST,Constant.WEST,Constant.SOUTH]:
		if not cubeInfo[Constant.CUBE_FACES].has(key):
			continue
		var face:Array
		match key:
			Constant.UP:
				face=[cubePoint[2],cubePoint[3],cubePoint[7],cubePoint[6]]
			Constant.DOWN:
				face=[cubePoint[0],cubePoint[4],cubePoint[5],cubePoint[1]]
			Constant.NORTH:
				face=[cubePoint[3],cubePoint[2],cubePoint[0],cubePoint[1]]
			Constant.EAST:
				face=[cubePoint[7],cubePoint[3],cubePoint[1],cubePoint[5]]
			Constant.WEST:
				face=[cubePoint[2],cubePoint[6],cubePoint[4],cubePoint[0]]
			Constant.SOUTH:
				face=[cubePoint[6],cubePoint[7],cubePoint[5],cubePoint[4]]
		var edge1 = face[1] - face[0]
		var edge2 = face[2] - face[0]
		var normal = edge2.cross(edge1).normalized()
		faces=[
			[face[0],face[1],face[2],normal],
			[face[0],face[2],face[3],normal]
		]
		var square:Array
		if cubeInfo[Constant.CUBE_FACES][key].has(Constant.UV):
			square=gen_square(cubeInfo[Constant.CUBE_FACES][key][Constant.UV])
		else:
			square=gen_square()
		var uv_vertex:Array=[[square[0],square[1],square[2]],[square[0],square[2],square[3]]]
		for i in range(2):
			var st = SurfaceTool.new()
			st.begin(Mesh.PRIMITIVE_TRIANGLES)
			st.set_normal(faces[i][3])
			var material = StandardMaterial3D.new()
			material.albedo_texture = TextureDataBase.getTexture(cubeInfo[Constant.CUBE_FACES][key][Constant.CUBE_TEXTURE],workPath)
			material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
			st.set_material(material)
			for j in range(3):
				st.set_uv(uv_vertex[i][j])
				st.add_vertex(faces[i][j])#頂点指定
			var mesh_instance = MeshInstance3D.new()
			mesh_instance.mesh = st.commit()
			add_child(mesh_instance)
	## Commit to a mesh.
	#var mesh = st.commit()
	#var mesh_instance = MeshInstance3D.new()
	#mesh_instance.mesh = mesh
	#add_child(mesh_instance)

func gen_square(corner:Array=[])->Array:
	var square:Array
	if corner==[]:
		square=[
			Vector2(0,0),
			Vector2(1,0),
			Vector2(1,1),
			Vector2(0,1)
		]
	else:
		square=[
			Vector2(corner[0],corner[1])/16,
			Vector2(corner[2],corner[1])/16,
			Vector2(corner[2],corner[3])/16,
			Vector2(corner[0],corner[3])/16
		]
	return square
