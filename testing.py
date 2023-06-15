import unittest
from unittest.mock import MagicMock

from PyQt5.QtGui import QPixmap
from PyQt5.QtWidgets import QApplication, QListWidgetItem
from main import RecipeFinderApp
from recipe_search_page import RecipeSearchPage, RecipeItem


class TestRecipeFinderApp(unittest.TestCase):
    def setUp(self):
        self.app = QApplication([])
        self.recipe_finder = RecipeFinderApp()

    def test_toggle_navbar(self):
        self.recipe_finder.dock.isHidden = MagicMock(return_value=True)
        self.recipe_finder.dock.show = MagicMock()  # Mock the show method
        self.recipe_finder.toggle_navbar()
        self.recipe_finder.dock.show.assert_called_once()

        self.recipe_finder.dock.isHidden = MagicMock(return_value=False)
        self.recipe_finder.dock.hide = MagicMock()  # Mock the hide method
        self.recipe_finder.toggle_navbar()
        self.recipe_finder.dock.hide.assert_called_once()


class TestRecipeSearchPage(unittest.TestCase):
    def setUp(self):
        self.app = QApplication([])
        self.recipe_finder = RecipeFinderApp()
        self.recipe_search_page = RecipeSearchPage(self.recipe_finder)

    def test_display_recipe_details(self):
        recipe_title = "Recipe 1"
        item = QListWidgetItem()
        self.recipe_search_page.result_display.itemWidget = MagicMock(
            return_value=RecipeItem(recipe_title, QPixmap()))  # Mock the itemWidget method
        self.recipe_search_page.main_window.stacked_layout.setCurrentIndex = MagicMock()  # Mock the setCurrentIndex method
        self.recipe_search_page.main_window.recipe_details_page.update_details = MagicMock()  # Mock the update_details method
        self.recipe_search_page.display_recipe_details(item)
        self.recipe_search_page.result_display.itemWidget.assert_called_once_with(item)
        self.recipe_search_page.main_window.stacked_layout.setCurrentIndex.assert_called_once_with(3)
        self.recipe_search_page.main_window.recipe_details_page.update_details.assert_called_once_with(recipe_title)





if __name__ == '__main__':
    unittest.main()

