class_name Cube
extends Node

var cube:Array
var cubeRotateX:float
var cubeRotateY:float

func _init(cubeInfo:Dictionary,workPath:String,blockRotateX:float=0,blockRotateY:float=0) -> void:
	var from:Array=cubeInfo[Constant.CUBE_FROM]
	var to:Array=cubeInfo[Constant.CUBE_TO]
	for i in range(0,8):#始点/終点の情報から直方体の頂点を割り出す
		var x:float
		var y:float
		var z:float
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
		var point:Vector3=Vector3(x,y,z)/Constant.BLOCK_PIXEL
		if cubeInfo.has(Constant.CUBE_ROTATION):
			var origin=Vector3(cubeInfo[Constant.CUBE_ROTATION][Constant.CUBE_ORIGIN][0],cubeInfo[Constant.CUBE_ROTATION][Constant.CUBE_ORIGIN][1],cubeInfo[Constant.CUBE_ROTATION][Constant.CUBE_ORIGIN][2])/Constant.BLOCK_PIXEL
			match cubeInfo[Constant.CUBE_ROTATION][Constant.CUBE_AXIS]:
				"x":
					point=rotate(point,origin,Vector3(1,0,0),cubeInfo[Constant.CUBE_ROTATION][Constant.CUBE_ANGLE])
				"y":
					point=rotate(point,origin,Vector3(0,1,0),cubeInfo[Constant.CUBE_ROTATION][Constant.CUBE_ANGLE])
				"z":
					point=rotate(point,origin,Vector3(0,0,1),cubeInfo[Constant.CUBE_ROTATION][Constant.CUBE_ANGLE])
		point=rotate(point,Constant.BLOCK_CENTER,Vector3(1,0,0),blockRotateX)
		point=rotate(point,Constant.BLOCK_CENTER,Vector3(0,-1,0),blockRotateY)
		cubeRotateX=blockRotateX
		cubeRotateY=blockRotateY
		cube.append(point)
	#make_mesh(cube,cubeInfo,workPath)

func _to_string() -> String:
	return str(cube)

#func move(vec:Vector3):
	#for i in len(cube):
		#cube[i]+=vec

#func make_mesh(cubePoint:Array,cubeInfo:Dictionary,workPath:String):
	#var faces:Array
	#for key in [Constant.UP,Constant.DOWN,Constant.NORTH,Constant.EAST,Constant.WEST,Constant.SOUTH]:
		#if not cubeInfo[Constant.CUBE_FACES].has(key):
			#continue
		#var face:Array
		#match key:
			#Constant.UP:
				#face=[cubePoint[2],cubePoint[3],cubePoint[7],cubePoint[6]]
			#Constant.DOWN:
				#face=[cubePoint[4],cubePoint[5],cubePoint[1],cubePoint[0]]
			#Constant.NORTH:
				#face=[cubePoint[3],cubePoint[2],cubePoint[0],cubePoint[1]]
			#Constant.EAST:
				#face=[cubePoint[7],cubePoint[3],cubePoint[1],cubePoint[5]]
			#Constant.WEST:
				#face=[cubePoint[2],cubePoint[6],cubePoint[4],cubePoint[0]]
			#Constant.SOUTH:
				#face=[cubePoint[6],cubePoint[7],cubePoint[5],cubePoint[4]]
		#var edge1 = face[1] - face[0]
		#var edge2 = face[2] - face[0]
		#var normal = edge2.cross(edge1).normalized()
		#faces=[
			#[face[0],face[1],face[2],normal],
			#[face[0],face[2],face[3],normal]
		#]
		#var square:Array
		#if cubeInfo[Constant.CUBE_FACES][key].has(Constant.UV):
			#square=gen_square(cubeInfo[Constant.CUBE_FACES][key][Constant.UV])
		#else:
			#square=gen_square()
		#var uv_vertex:Array=[[square[0],square[1],square[2]],[square[0],square[2],square[3]]]
		#if cubeInfo.has([Constant.CUBE_ROTATION]):
			#pass
			##match cubeInfo[Constant.CUBE_ROTATION]
		#for i in range(2):
			#var st = SurfaceTool.new()
			#st.begin(Mesh.PRIMITIVE_TRIANGLES)
			#st.set_normal(faces[i][3])
			#var material = StandardMaterial3D.new()
			#material.albedo_texture = TextureDataBase.getTexture(cubeInfo[Constant.CUBE_FACES][key][Constant.CUBE_TEXTURE],workPath)
			#material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
			#material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
			#st.set_material(material)
			#for j in range(3):
				#st.set_uv(uv_vertex[i][j])
				#st.add_vertex(faces[i][j])#頂点指定
			#var mesh_instance = MeshInstance3D.new()
			#mesh_instance.mesh = st.commit()
			#add_child(mesh_instance)
	### Commit to a mesh.
	##var mesh = st.commit()
	##var mesh_instance = MeshInstance3D.new()
	##mesh_instance.mesh = mesh
	##add_child(mesh_instance)
#
#func gen_square(corner:Array=[])->Array:
	#var square:Array
	#if corner==[]:
		#square=[
			#Vector2(0,0),
			#Vector2(1,0),
			#Vector2(1,1),
			#Vector2(0,1)
		#]
	#else:
		#square=[
			#Vector2(corner[0],corner[1])/Constant.BLOCK_PIXEL,
			#Vector2(corner[2],corner[1])/Constant.BLOCK_PIXEL,
			#Vector2(corner[2],corner[3])/Constant.BLOCK_PIXEL,
			#Vector2(corner[0],corner[3])/Constant.BLOCK_PIXEL
		#]
	#return square

func rotate(point:Vector3,center:Vector3,axis:Vector3,angle:float)->Vector3:
	var tmp:Vector3=point-center
	return tmp.rotated(axis.normalized(),deg_to_rad(angle))+center
