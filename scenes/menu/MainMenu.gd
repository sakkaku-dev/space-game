extends Control

class_name MainMenu

signal start_game

onready var main := $Main
onready var options := $Options

onready var start_btn = $Main/VBoxContainer/Start

const menu_stack = []
var current_menu setget _set_current_menu


func _ready():
	for child in get_children():
		child.hide()
	_open_menu(main)


func _unhandled_input(event):
	if event.is_action("ui_cancel"):
		_back_menu()


func _set_current_menu(menu) -> void:
	current_menu = menu
	current_menu.show()


func _open_menu(menu, last_menu = current_menu):
	if last_menu:
		menu_stack.push_back(last_menu)
	self.current_menu = menu


func _back_menu():
	if menu_stack.size() == 0: return
	
	current_menu.hide()
	
	var last_menu = menu_stack.pop_back()
	self.current_menu = last_menu

func _on_Start_pressed():
	emit_signal("start_game")
	hide()


func _on_Options_pressed():
	_open_menu(options)


func _on_Exit_pressed():
	get_tree().quit()
