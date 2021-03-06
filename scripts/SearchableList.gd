extends VBoxContainer

signal selected(what)

func clear():
	for item in $ScrollList/List.get_children(): item.queue_free()

func reset_search():
	$SearchBar.text = ""
	search_for("")

func add_item(t):
	var button = Button.new()
	var label = Label.new()
	label.text = t
	label.autowrap = true
	button.anchor_bottom = 1
	button.anchor_right = 1
	button.show_behind_parent = true
	button.connect("pressed",self,"emit_signal",["selected",$ScrollList/List.get_child_count()])
	$ScrollList/List.add_child(label)
	label.add_child(button)

func get_at(idx):
	return $ScrollList/List.get_child(idx).text

func has_items():
	return $ScrollList/List.get_child_count() != 0

func search_for(text):
	for item in $ScrollList/List.get_children():
		if text == "":
			item.show()
			continue
			
		if not (text.to_lower() in item.text.to_lower()): 
			item.hide()
		else: 
			item.show()
