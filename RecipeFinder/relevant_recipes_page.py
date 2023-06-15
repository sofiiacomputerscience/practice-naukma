from PyQt5.QtWidgets import QWidget, QVBoxLayout, QLabel

class RelevantRecipesPage(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        layout = QVBoxLayout(self)
        layout.addWidget(QLabel("Relevant Recipes Page", self))