from PyQt5.QtWidgets import QWidget, QVBoxLayout, QLabel, QPushButton
from PyQt5.QtGui import QPixmap, QFont
from PyQt5.QtCore import Qt


class RecipeDetailsPage(QWidget):
    def __init__(self, main_window, parent=None):
        super().__init__(parent)
        self.main_window = main_window
        self.layout = QVBoxLayout(self)

        self.title_label = QLabel(self)
        self.title_label.setFont(QFont('Arial', 20))

        self.image_label = QLabel(self)

        self.details_label = QLabel(self)
        self.details_label.setWordWrap(True)
        self.details_label.setAlignment(Qt.AlignJustify)

        self.details_for_label = QLabel(self)
        self.details_for_label.setAlignment(Qt.AlignCenter)

        self.back_button = QPushButton("Back", self)
        self.back_button.clicked.connect(self.go_back)

        self.layout.addWidget(self.title_label)
        self.layout.addWidget(self.image_label)
        self.layout.addWidget(self.details_label)
        self.layout.addWidget(self.details_for_label)
        self.layout.addWidget(self.back_button)

    def update_recipe(self, recipe):
        self.title_label.setText(recipe['title'])
        self.image_label.setPixmap(recipe['image'])
        self.details_label.setText(recipe['details'])

    def update_details(self, recipe_title):
        # Only demonstrative variant
        print(f"Displaying details for {recipe_title}")
        # Update the new label text
        self.details_for_label.setText(f"Details for {recipe_title}")

    def go_back(self):
        self.main_window.stacked_layout.setCurrentIndex(0)

