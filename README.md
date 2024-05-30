# CustomSwitch

CustomSwitch is a customizable switch based on `UIControl` that allows easy modification of the appearance and behavior of the switch.
CustomSwitch — это кастомизированный переключатель, созданный на базе `UIControl`, который позволяет легко изменять внешний вид и поведение переключателя.

![On/Off](https://raw.githubusercontent.com/Vlad-tdk/Customizable-UISwitch/main/%D0%A1ustomizable%20UISwitch/03.png)

## Main Features

- Customizable colors for on/off states.
- Customizable colors for disabled states.
- Option to enable/disable bounce effect when switching.
- Change text color for on/off states.
- Easy integration and use.


## Основные возможности

- Настраиваемые цвета для состояния включено/выключено.
- Настраиваемые цвета для состояния с отключенной возможностью взаимодействия.
- Возможность включения/выключения эффекта "подпрыгивания" при переключении.
- Изменение цвета текста для состояний включено/выключено.
- Простая интеграция и использование.

## Установка

1. Clone the repository:
1. Склонируйте репозиторий:

```bash
git clone https://github.com/yourusername/CustomSwitch.git
```
2. Переместите файлы CustomSwitch.swift в ваш проект.
2. Move the CustomSwitch.swift file to your project.

Usage
Step 1: Import CustomSwitch
Использование
Шаг 1: Импортируйте CustomSwitch
```swift
import UIKit
```
Step 2: Create an instance of CustomSwitch
Шаг 2: Создайте экземпляр CustomSwitch

```swift
let customSwitch = CustomSwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 77))
```
Step 3: Customize the switch appearance (optional)
Шаг 3: Настройте внешний вид переключателя (опционально)

```swift
customSwitch.thumbOnTintColor = .blue
customSwitch.thumbOffTintColor = .gray
customSwitch.trackOnTintColor = .green
customSwitch.trackOffTintColor = .red
customSwitch.thumbDisabledTintColor = .lightGray
customSwitch.trackDisabledTintColor = .darkGray
customSwitch.tumbOnTitleColor = .white
customSwitch.tumbOffTitleColor = .black
```
Step 4: Add the switch to your view
Шаг 4: Добавьте переключатель на ваш view

```swift
view.addSubview(customSwitch)

```

Step 5: Add a handler for the value changed event
Шаг 5: Добавьте обработчик для события изменения состояния
```swift
customSwitch.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)

@objc func switchStateChanged(_ mySwitch: CustomSwitch) {
    // Обновление UI или другие действия при изменении состояния переключателя
}
```
License
This project is licensed under the MIT License. See the LICENSE file for details.
