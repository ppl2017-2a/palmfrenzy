extends Node
var file = null

func open_file(filename):
	file = File.new()
	if not file.file_exists(filename):
		print("Oops, save file does not exist.")
		return
	file.open(filename,File.READ)
	return file
	
func write_file(filename, data):
	file = File.new()
	file.open(filename,File.WRITE)
	file.store_line(data)
	close_file()

func close_file():
	file.close()
