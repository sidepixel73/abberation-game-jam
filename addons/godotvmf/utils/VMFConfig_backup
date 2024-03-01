class_name VMFConfig;

static var config = {};

static func getConfig():
	if not config:
		checkProjectConfig();
	return config;

static func createConfig():
	var file = FileAccess.open('res://vmf.config.json', FileAccess.WRITE);

	var defaultConfig = {
	"entitiesFolder": "res://addons/godotvmf/entities/",
	"gameInfoPath": "S:/SteamLibrary/steamapps/common/Team Fortress 2/hl2/",
	"instancesFolder": "res://addons/godotvmf/instances/",
	"materialsFolder": "res://addons/godotvmf/materals/",
	"mdl2obj": "C:/Users/LeV73/Desktop/Godot/abberation-game-jam/addons/godotvmf/3rdparty/mdl2obj/",
	"modelsFolder": "res://addons/godotvmf/models/",
	"nodeConfig": {
		"defaultTextureSize": 512,
		"fallbackMaterial": null,
		"generateCollision": true,
		"generateCollisionForModel": true,
		"ignoreTextures": [
			"TOOLS/TOOLSNODRAW"
		],
		"importModels": false,
		"importScale": 0.025,
		"overrideModels": true,
		"textureImportMode": 1
	},
	"vtflib": "C:/Users/LeV73/Desktop/Godot/abberation-game-jam/addons/godotvmf/3rdparty/vtflib"
	};

	file.store_string(JSON.stringify(defaultConfig, "\t"));
	file.close();

static func checkProjectConfig():
	if not FileAccess.file_exists('res://vmf.config.json'):
		createConfig();

	var file = FileAccess.open('res://vmf.config.json', FileAccess.READ);
	config = JSON.parse_string(file.get_as_text());
	config.nodeConfig.ignoreTextures = config.nodeConfig.ignoreTextures\
			.map(func(i): return i.to_upper());

	file.close();
