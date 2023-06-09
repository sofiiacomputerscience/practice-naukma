# Налаштування середовища проекту

В даному файлі ви знайдете інструкції для налаштування середовища розробки проекту і використання його компонентів. 

## Вимоги

Перед початком налаштування проекту, впевніться, що ви маєте наступні компоненти:

- Xcode: Інтегроване середовище розробки (IDE) для мови програмування Swift, версія Xcode мінімально має бути XCode 11. Для перевірки версії XCode напишіть `xcodebuild -version` в Терміналі вашого ноутбука.
* Swift: Мова програмування, що використовується для розробки проекту, версія Xcode мінімально має бути XCode 5.1. Для перевірки версії Swift напишіть `swift --version` в Терміналі вашого ноутбука.
+ SwiftUI: Бібліотека для створення інтерфейсу користувача (UI) у проекті.
- Edamam API: API для пошуку рецептів та отримання відповідних даних.

## Інструкції
 
1. Xcode: Встановіть Xcode, якщо він ще не встановлений, шляхом завантаження з офіційного сайту розробника Apple і виконайте інсталяційні кроки.

2. Клонування проекту: Відкрийте термінал і виконайте наступну команду, щоб склонувати репозиторій проекту на свій локальний комп'ютер:
`git clone https://github.com/sofiiacomputerscience/practice-naukma.git` Або ви можете завантажити папку проекта "Recipe Finder" з даного репозиторію на Git Hub.

3. Відкриття проекту: Запустіть Xcode і виберіть опцію "Open" (Відкрити проект). Виберіть папку проекту, яку ви склонували або завантажили на попередньому кроці, і натисніть кнопку "Open" (Відкрити).

4. Edamam API: Для використання Edamam API вам потрібно мати ключ та ідентифікатор доступу API. Зареєструйтеся на веб-сайті Edamam, отримайте ключ доступу та ідентифікатор API і збережіть його. В файлі SearchViewзамініть "YOUR_API_KEY" та "YOUR_API_SECRET" на власний ключ доступу API та секрет Edamam.
   
5. Запуск проекту: Тепер ви готові запустити проект. Виберіть ціль (симулятор або підключений пристрій) та натисніть кнопку "Run" (Запустити) в Xcode.

## Додаткова інформація від команди розробників

Для отримання додаткової інформації щодо використання [SwiftUI](https://developer.apple.com/xcode/swiftui/) та роботи з [Edamam API](https://developer.edamam.com/edamam-docs-recipe-api) рекомендується переглянути відповідну документацію.
Якщо у вас виникають проблеми або питання щодо налаштування середовища проекту, ви можете звернутися до документації Xcode та Edamam API або шукати підтримку в спільноті розробників.



