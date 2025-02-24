extends SubMenuButton

signal back_button_clicked()

func click() -> void:
	back_button_clicked.emit()
