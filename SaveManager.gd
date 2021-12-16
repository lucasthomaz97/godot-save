extends Node

const data_path = "user://"
const format = '.save'
onready var GlobalProperties = {}

func get_global_property(key):
	return GlobalProperties[key]
	
func set_global_property(key, value):
	GlobalProperties[key] = value

func get_all_saves_on_folder(folder=''):
	var path = data_path+folder
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true)
	var file = str(dir.get_next()).replace(format, '')
	while file != '':
		if file != 'logs':
			files.append(file)
		file = str(dir.get_next()).replace(format, '')
	return files

func load_data(save_name, config_folder=''):
	var path = data_path+'/'+config_folder+'/'+save_name+format if config_folder != '' else data_path+'/'+save_name+format
	var save = File.new()
	if save.file_exists(path):
		save.open(path, File.READ)
		var data = str2var(save.get_as_text())
		save.close()
		return [data, config_folder]

func remove_data(save_name, config_folder=''):
	var path = data_path+'/'+config_folder+'/'+save_name+format if config_folder != '' else data_path+'/'+save_name+format
	var dir = Directory.new()
	dir.remove(path)

func save_data(data={}, save_name='Default', config_folder=''):
	var save = File.new()
	var path = data_path+'/'+config_folder+'/'+save_name+format if config_folder != '' else data_path+'/'+save_name+format
	save.open(path, File.WRITE)
	save.store_string(var2str(data))
	save.close()
	return config_folder
