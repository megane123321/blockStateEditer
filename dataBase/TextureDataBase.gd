class_name TextureDataBase

static var textureData:Dictionary

static func getTexture(path:String,workPath:String)->Texture2D:
	if textureData.has(path):#テクスチャが既に読まれていた場合
		return textureData[path]
	else:
		print(path)
		if ResourceLoader.exists(GameFilePath.getTexturePath(path,workPath)):
			textureData[path]=ResourceLoader.load(GameFilePath.getTexturePath(path,workPath)) as Texture2D
		else:
			textureData[path]=ResourceLoader.load(GameFilePath.getTexturePath(Constant.NULL_TEXTURE,workPath)) as Texture2D
	return textureData[path]
