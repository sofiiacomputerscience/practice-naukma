from PyQt5.QtWidgets import (QWidget, QHBoxLayout, QLabel, QLineEdit, QPushButton,
                             QComboBox, QVBoxLayout, QListWidget, QListWidgetItem)
from PyQt5.QtGui import QPixmap, QFont
import requests


class RecipeItem(QWidget):
    def __init__(self, title, pixmap, parent=None):
        super().__init__(parent)
        layout = QVBoxLayout(self)

        self.image_label = QLabel(self)
        self.image_label.setPixmap(pixmap)

        self.title_label = QLabel(title, self)
        self.title_label.setFont(QFont('Arial', 13))

        layout.addWidget(self.image_label)
        layout.addWidget(self.title_label)


class SearchBar(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.layout = QHBoxLayout(self)

        self.search_label = QLabel("Enter a recipe name or keywords:", self)
        self.search_input = QLineEdit(self)
        self.search_button = QPushButton("Search", self)

        # Styling Widgets
        self.setStyleSheet("""
                   QLabel {
                       font: 15px Arial, sans-serif;
                   }

                   QLineEdit {
                       font: 13px Arial, sans-serif;
                       padding: 5px;
                       background: white;
                       border-radius: 5px;
                   }

                   QPushButton {
                       font: 13px Arial, sans-serif;
                       color: white;
                       background: #5cb85c;
                       padding: 10px;
                       border-radius: 5px;
                   }
               """)

        self.layout.addWidget(self.search_label)
        self.layout.addWidget(self.search_input)
        self.layout.addWidget(self.search_button)


class FilterAndSortBar(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.layout = QHBoxLayout(self)

        self.filter_label = QLabel("Filter by:", self)
        self.filter_options = QComboBox(self)
        self.filter_options.addItem("Cooking Time")
        self.filter_options.addItem("Difficulty Level")
        self.filter_options.addItem("Rating")

        self.dietary_pref_label = QLabel("Dietary Preferences:", self)
        self.dietary_pref_options = QComboBox(self)
        self.dietary_pref_options.addItem("None")
        self.dietary_pref_options.addItem("Vegetarian")
        self.dietary_pref_options.addItem("Vegan")
        self.dietary_pref_options.addItem("Gluten Free")
        self.dietary_pref_options.addItem("Dairy Free")
        self.dietary_pref_options.addItem("Paleo")

        self.sort_label = QLabel("Sort by:", self)
        self.sort_options = QComboBox(self)
        self.sort_options.addItem("Relevance")
        self.sort_options.addItem("Cooking Time")
        self.sort_options.addItem("Rating")

        self.layout.addWidget(self.filter_label)
        self.layout.addWidget(self.filter_options)
        self.layout.addWidget(self.dietary_pref_label)
        self.layout.addWidget(self.dietary_pref_options)
        self.layout.addWidget(self.sort_label)
        self.layout.addWidget(self.sort_options)


class RecipeSearchPage(QWidget):
    def __init__(self, main_window):
        super().__init__(main_window)
        self.main_window = main_window

        self.search_bar = SearchBar(self)
        self.filter_and_sort_bar = FilterAndSortBar(self)
        self.result_label = QLabel("Search Results:", self)

        self.result_display = QListWidget(self)
        self.result_display.itemClicked.connect(self.display_recipe_details)  # Add this line

        self.layout = QVBoxLayout(self)
        self.layout.addWidget(self.search_bar)
        self.layout.addWidget(self.filter_and_sort_bar)
        self.layout.addWidget(self.result_label)
        self.layout.addWidget(self.result_display)

        self.search_bar.search_button.clicked.connect(self.search_recipe)

    def search_recipe(self):
        recipe_query = self.search_bar.search_input.text()
        filter_option = self.filter_and_sort_bar.filter_options.currentText()
        dietary_pref = self.filter_and_sort_bar.dietary_pref_options.currentText()
        sort_option = self.filter_and_sort_bar.sort_options.currentText()

        base_url = "https://api.spoonacular.com/recipes/complexSearch"
        api_key = "6dba6a1cf0604e55b98eb7c8318c229e"
        params = {
            "query": recipe_query,
            "diet": dietary_pref,
            "sort": sort_option,
            "apiKey": api_key
        }

        response = requests.get(base_url, params=params)
        data = response.json()

        # Process the response data
        if "results" in data:
            results = data["results"]
            self.result_display.clear()
            for result in results:
                title = result["title"]
                image_url = result["image"]
                pixmap = self.load_image_from_url(image_url)

                item_widget = RecipeItem(title, pixmap)
                item = QListWidgetItem(self.result_display)
                item.setSizeHint(item_widget.sizeHint())
                self.result_display.addItem(item)
                self.result_display.setItemWidget(item, item_widget)

    def load_image_from_url(self, url):
        response = requests.get(url)
        image_data = response.content
        pixmap = QPixmap()
        pixmap.loadFromData(image_data)
        return pixmap

    def display_recipe_details(self, item):
        recipe_widget = self.result_display.itemWidget(item)
        recipe_title = recipe_widget.title_label.text()
        self.main_window.stacked_layout.setCurrentIndex(3)
        self.main_window.recipe_details_page.update_details(recipe_title)



