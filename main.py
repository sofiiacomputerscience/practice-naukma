# This is a sample Python script.

# Press ⌃R to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.


import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QPushButton, QDockWidget,
                             QStackedLayout, QWidget, QListWidget)
from recipe_search_page import RecipeSearchPage
from relevant_recipes_page import RelevantRecipesPage
from my_recipes_page import MyRecipesPage
from recipe_details_page import RecipeDetailsPage


class RecipeFinderApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Recipe Finder")
        self.setGeometry(100, 100, 800, 600)

        self.dock = QDockWidget(self)
        self.navbar = QListWidget(self.dock)
        self.dock.setWidget(self.navbar)
        self.addDockWidget(1, self.dock)
        self.dock.hide()

        self.pages = QWidget(self)
        self.recipe_search_page = RecipeSearchPage(self)
        self.relevant_recipes_page = RelevantRecipesPage(self.pages)
        self.my_recipes_page = MyRecipesPage(self.pages)
        self.recipe_details_page = RecipeDetailsPage(self, self.pages)
        self.relevant_recipes_page.setVisible(False)
        self.my_recipes_page.setVisible(False)
        self.recipe_details_page.setVisible(False)

        self.navbar.addItem('Recipe Search')
        self.navbar.addItem('Relevant Recipes')
        self.navbar.addItem('My Recipes')

        self.stacked_layout = QStackedLayout(self.pages)
        self.stacked_layout.addWidget(self.recipe_search_page)
        self.stacked_layout.addWidget(self.relevant_recipes_page)
        self.stacked_layout.addWidget(self.my_recipes_page)
        self.stacked_layout.addWidget(self.recipe_details_page)

        self.navbar.currentRowChanged.connect(self.change_page)

        self.button = QPushButton('Menu', self)
        self.button.clicked.connect(self.toggle_navbar)
        self.setCentralWidget(self.pages)

    def toggle_navbar(self):
        if self.dock.isHidden():
            self.dock.show()
        else:
            self.dock.hide()

    def change_page(self, current):
        self.stacked_layout.setCurrentIndex(current)


if __name__ == '__main__':
    app = QApplication(sys.argv)
    recipe_finder = RecipeFinderApp()
    recipe_finder.show()
    sys.exit(app.exec_())
