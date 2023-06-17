#
# from PyQt5.QtWidgets import (
#     QWidget, QHBoxLayout, QLabel, QLineEdit, QPushButton,
#     QComboBox, QVBoxLayout, QListWidget, QListWidgetItem,
#     QGridLayout
# )
# from PyQt5.QtGui import QPixmap, QFont
# import requests
# import math
#
#
# class RecipeItem(QWidget):
#     def __init__(self, title, image_url, info, parent=None):
#         super().__init__(parent)
#         layout = QVBoxLayout(self)
#
#         self.image_label = QLabel(self)
#         self.load_image_from_url(image_url)  # Load image from URL
#         self.image_label.setScaledContents(True)
#
#         self.title_label = QLabel(title, self)
#         self.title_label.setFont(QFont('Arial', 13))
#
#         self.info_label = QLabel(info, self)
#
#         layout.addWidget(self.image_label)
#         layout.addWidget(self.title_label)
#         layout.addWidget(self.info_label)
#
#     def load_image_from_url(self, url):
#         response = requests.get(url)
#         image_data = response.content
#         pixmap = QPixmap()
#         pixmap.loadFromData(image_data)
#         self.image_label.setPixmap(pixmap)
#
#
# class SearchBar(QWidget):
#     def __init__(self, parent=None):
#         super().__init__(parent)
#         self.layout = QHBoxLayout(self)
#
#         self.search_label = QLabel("Enter a recipe name or keywords:", self)
#         self.search_input = QLineEdit(self)
#         self.search_button = QPushButton("Search", self)
#
#         # Styling Widgets
#         self.setStyleSheet("""
#             QLabel {
#                 font: 15px Arial, sans-serif;
#             }
#
#             QLineEdit {
#                 font: 13px Arial, sans-serif;
#                 padding: 5px;
#                 background: white;
#                 border-radius: 5px;
#             }
#
#             QPushButton {
#                 font: 13px Arial, sans-serif;
#                 color: white;
#                 background: #5cb85c;
#                 padding: 10px;
#                 border-radius: 5px;
#             }
#         """)
#
#         self.layout.addWidget(self.search_label)
#         self.layout.addWidget(self.search_input)
#         self.layout.addWidget(self.search_button)
#
#
# class FilterAndSortBar(QWidget):
#     def __init__(self, parent=None):
#         super().__init__(parent)
#         self.layout = QHBoxLayout(self)
#
#         self.filter_label = QLabel("Filter by:", self)
#         self.filter_options = QComboBox(self)
#         self.filter_options.addItem("Cooking Time")
#         self.filter_options.addItem("Difficulty Level")
#         self.filter_options.addItem("Rating")
#
#         self.dietary_pref_label = QLabel("Dietary Preferences:", self)
#         self.dietary_pref_options = QComboBox(self)
#         self.dietary_pref_options.addItem("None")
#         self.dietary_pref_options.addItem("Vegetarian")
#         self.dietary_pref_options.addItem("Vegan")
#         self.dietary_pref_options.addItem("Gluten Free")
#         self.dietary_pref_options.addItem("Dairy Free")
#         self.dietary_pref_options.addItem("Paleo")
#
#         self.sort_label = QLabel("Sort by:", self)
#         self.sort_options = QComboBox(self)
#         self.sort_options.addItem("Relevance")
#         self.sort_options.addItem("Cooking Time")
#         self.sort_options.addItem("Rating")
#
#         self.layout.addWidget(self.filter_label)
#         self.layout.addWidget(self.filter_options)
#         self.layout.addWidget(self.dietary_pref_label)
#         self.layout.addWidget(self.dietary_pref_options)
#         self.layout.addWidget(self.sort_label)
#         self.layout.addWidget(self.sort_options)
#
#
# class PagePanel(QWidget):
#     def __init__(self, parent=None):
#         super().__init__(parent)
#         self.layout = QGridLayout(self)
#         self.page_buttons = []
#
#     def set_pages(self, total_pages):
#         self.clear_page_buttons()
#         self.page_buttons = []
#         for i in range(total_pages):
#             button = QPushButton(str(i + 1), self)
#             button.clicked.connect(lambda checked, idx=i: self.go_to_page(idx + 1))
#             self.page_buttons.append(button)
#             self.layout.addWidget(button, 0, i)
#
#     def clear_page_buttons(self):
#         for button in self.page_buttons:
#             button.setParent(None)
#         self.page_buttons = []
#
#     def go_to_page(self, page):
#         self.parent().current_page = page
#         self.parent().display_current_page()
#
#
# class RecipeSearchPage(QWidget):
#     def __init__(self, main_window):
#         super().__init__(main_window)
#         self.main_window = main_window
#
#         self.search_bar = SearchBar(self)
#         self.filter_and_sort_bar = FilterAndSortBar(self)
#         self.result_label = QLabel("Search Results:", self)
#
#         self.result_display = QListWidget(self)
#         self.result_display.itemClicked.connect(self.display_recipe_details)  # Add this line
#
#         self.page_panel = PagePanel(self)
#
#         self.layout = QVBoxLayout(self)
#         self.layout.addWidget(self.search_bar)
#         self.layout.addWidget(self.filter_and_sort_bar)
#         self.layout.addWidget(self.result_label)
#         self.layout.addWidget(self.result_display)
#         self.layout.addWidget(self.page_panel)
#
#         self.search_bar.search_button.clicked.connect(self.search_recipe)
#
#         self.page_size = 5  # Number of recipes per page
#         self.current_page = 1  # Current page number
#         self.total_pages = 1  # Total number of pages
#         self.results = []  # List to store all the recipes from the API response
#
#         self.bottom_bar_layout = QHBoxLayout()
#         self.layout.addLayout(self.bottom_bar_layout)  # Move this line here
#
#         self.previous_button = QPushButton("Previous", self)
#         self.next_button = QPushButton("Next", self)
#         self.previous_button.setVisible(False)
#         self.next_button.setVisible(False)
#
#         self.previous_button.clicked.connect(self.go_to_previous_page)
#         self.next_button.clicked.connect(self.go_to_next_page)
#
#         self.bottom_bar_layout.addWidget(self.previous_button)
#         self.bottom_bar_layout.addWidget(self.next_button)
#
#     def search_recipe(self):
#         recipe_query = self.search_bar.search_input.text()
#
#         base_url = "https://api.edamam.com/api/recipes/v2"
#         app_id = "5136eaf5"
#         app_key = "cf41752be0cc2665a0067b8fa21df934"
#
#         params = {
#             "type": "public",
#             "q": recipe_query,
#             "app_id": app_id,
#             "app_key": app_key,
#             "from": (self.current_page - 1) * self.page_size,
#             "to": self.current_page * self.page_size
#         }
#
#         response = requests.get(base_url, params=params)
#         data = response.json()
#
#         if "hits" in data:
#             self.results = data["hits"]
#             self.total_pages = math.ceil(len(self.results) / self.page_size)
#             self.display_current_page()
#             self.page_panel.set_pages(self.total_pages)
#
#         self.update_pagination_buttons()
#
#     def display_current_page(self):
#         self.result_display.clear()
#         start_index = (self.current_page - 1) * self.page_size
#         end_index = self.current_page * self.page_size
#
#         for result in self.results[start_index:end_index]:
#             recipe = result["recipe"]
#             title = recipe["label"]
#             image_url = recipe["image"]
#             info = f"Yields: {recipe['yield']} • Calories: {round(recipe['calories'])}"
#
#             item_widget = RecipeItem(title, image_url, info)
#             item = QListWidgetItem(self.result_display)
#             item.setSizeHint(item_widget.sizeHint())
#             self.result_display.addItem(item)
#             self.result_display.setItemWidget(item, item_widget)
#
#     def display_recipe_details(self, item):
#         recipe_widget = self.result_display.itemWidget(item)
#         recipe_title = recipe_widget.title_label.text()
#         self.main_window.stacked_layout.setCurrentIndex(3)
#         self.main_window.recipe_details_page.update_details(recipe_title)
#
#     def go_to_previous_page(self):
#         if self.current_page > 1:
#             self.current_page -= 1
#             self.display_current_page()
#             self.update_pagination_buttons()
#
#     def go_to_next_page(self):
#         if self.current_page < self.total_pages:
#             self.current_page += 1
#             self.display_current_page()
#             self.update_pagination_buttons()
#
#     def update_pagination_buttons(self):
#         self.previous_button.setVisible(self.current_page > 1)
#         self.next_button.setVisible(self.current_page < self.total_pages)
#
from PyQt5.QtWidgets import (
    QWidget, QHBoxLayout, QLabel, QLineEdit, QPushButton,
    QComboBox, QVBoxLayout, QListWidget, QListWidgetItem,
    QGridLayout
)
from PyQt5.QtGui import QPixmap, QFont
import requests
import math


class RecipeItem(QWidget):
    def __init__(self, title, image_url, info, parent=None):
        super().__init__(parent)
        layout = QVBoxLayout(self)

        self.image_label = QLabel(self)
        self.load_image_from_url(image_url)  # Load image from URL
        self.image_label.setScaledContents(True)

        self.title_label = QLabel(title, self)
        self.title_label.setFont(QFont('Arial', 13))

        self.info_label = QLabel(info, self)

        layout.addWidget(self.image_label)
        layout.addWidget(self.title_label)
        layout.addWidget(self.info_label)

    def load_image_from_url(self, url):
        response = requests.get(url)
        image_data = response.content
        pixmap = QPixmap()
        pixmap.loadFromData(image_data)
        self.image_label.setPixmap(pixmap)


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


class PagePanel(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.layout = QGridLayout(self)
        self.page_buttons = []

    def set_pages(self, total_pages):
        self.clear_page_buttons()
        self.page_buttons = []
        for i in range(total_pages):
            button = QPushButton(str(i + 1), self)
            button.clicked.connect(lambda checked, idx=i: self.go_to_page(idx + 1))
            self.page_buttons.append(button)
            self.layout.addWidget(button, 0, i)

    def clear_page_buttons(self):
        for button in self.page_buttons:
            button.setParent(None)
        self.page_buttons = []

    def go_to_page(self, page):
        self.parent().current_page = page
        self.parent().display_current_page()


class RecipeSearchPage(QWidget):
    def __init__(self, main_window):
        super().__init__(main_window)
        self.main_window = main_window

        self.search_bar = SearchBar(self)
        self.filter_and_sort_bar = FilterAndSortBar(self)
        self.result_label = QLabel("Search Results:", self)

        self.result_display = QListWidget(self)
        self.result_display.itemClicked.connect(self.display_recipe_details)  # Add this line

        self.page_panel = PagePanel(self)

        self.layout = QVBoxLayout(self)
        self.layout.addWidget(self.search_bar)
        self.layout.addWidget(self.filter_and_sort_bar)
        self.layout.addWidget(self.result_label)
        self.layout.addWidget(self.result_display)
        self.layout.addWidget(self.page_panel)

        self.search_bar.search_button.clicked.connect(self.search_recipe)

        self.page_size = 5  # Number of recipes per page
        self.current_page = 1  # Current page number
        self.total_pages = 4  # Total number of pages
        self.results = []  # List to store all the recipes from the API response

        self.bottom_bar_layout = QHBoxLayout()
        self.layout.addLayout(self.bottom_bar_layout)  # Move this line here

        # self.previous_button = QPushButton("Previous", self)
        # self.next_button = QPushButton("Next", self)
        # self.previous_button.setVisible(False)
        # self.next_button.setVisible(False)
        #
        # self.previous_button.clicked.connect(self.go_to_previous_page)
        # self.next_button.clicked.connect(self.go_to_next_page)
        #
        # self.bottom_bar_layout.addWidget(self.previous_button)
        # self.bottom_bar_layout.addWidget(self.next_button)

    def search_recipe(self):
        recipe_query = self.search_bar.search_input.text()

        base_url = "https://api.edamam.com/api/recipes/v2"

        app_id = "5136eaf5"
        app_key = "cf41752be0cc2665a0067b8fa21df934"

        params = {
            "type": "public",
            "q": recipe_query,
            "app_id": app_id,
            "app_key": app_key,
            "from": (self.current_page - 1) * self.page_size,
            "to": self.current_page * self.page_size
        }

        response = requests.get(base_url, params=params)
        data = response.json()

        if "hits" in data:
            self.results = data["hits"]
            self.total_pages = math.ceil(len(self.results) / self.page_size)
            self.display_current_page()
            self.page_panel.set_pages(self.total_pages)

        # self.update_pagination_buttons()

    def display_current_page(self):
        self.result_display.clear()
        start_index = (self.current_page - 1) * self.page_size
        end_index = self.current_page * self.page_size

        for result in self.results[start_index:end_index]:
            recipe = result["recipe"]
            title = recipe["label"]
            image_url = recipe["image"]
            info = f"Yields: {recipe['yield']} • Calories: {round(recipe['calories'])}"

            item_widget = RecipeItem(title, image_url, info)
            item = QListWidgetItem(self.result_display)
            item.setSizeHint(item_widget.sizeHint())
            self.result_display.addItem(item)
            self.result_display.setItemWidget(item, item_widget)

    def display_recipe_details(self, item):
        recipe_widget = self.result_display.itemWidget(item)
        recipe_title = recipe_widget.title_label.text()
        self.main_window.stacked_layout.setCurrentIndex(3)
        self.main_window.recipe_details_page.update_details(recipe_title)

    # def go_to_previous_page(self):
    #     if self.current_page > 1:
    #         self.current_page -= 1
    #         self.display_current_page()
    #         self.update_pagination_buttons()
    #
    # def go_to_next_page(self):
    #     if self.current_page < self.total_pages:
    #         self.current_page += 1
    #         self.display_current_page()
    #         self.update_pagination_buttons()
    #
    # def update_pagination_buttons(self):
    #     self.previous_button.setVisible(self.current_page > 1)
    #     self.next_button.setVisible(self.current_page < self.total_pages)
    #     self.previous_button.setEnabled(self.current_page > 1)
    #     self.next_button.setEnabled(self.current_page < self.total_pages)
    #
    #     if self.current_page == self.total_pages:
    #         self.next_button.setVisible(False)



