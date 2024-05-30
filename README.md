# CustomSwitch

CustomSwitch — это кастомизированный переключатель, созданный на базе `UIControl`, который позволяет легко изменять внешний вид и поведение переключателя.

## Основные возможности

- Настраиваемые цвета для состояния включено/выключено.
- Настраиваемые цвета для состояния с отключенной возможностью взаимодействия.
- Возможность включения/выключения эффекта "подпрыгивания" при переключении.
- Изменение цвета текста для состояний включено/выключено.
- Простая интеграция и использование.

## Установка

1. Склонируйте репозиторий:

```bash
git clone https://github.com/yourusername/CustomSwitch.git
```
2. Переместите файлы CustomSwitch.swift в ваш проект.

Использование

Шаг 1: Импортируйте CustomSwitch
```swift
import UIKit
```
Шаг 2: Создайте экземпляр CustomSwitch

```swift
let customSwitch = CustomSwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 77))
```
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
Шаг 5: Добавьте обработчик для события изменения состояния
```swift
customSwitch.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)

@objc func switchStateChanged(_ mySwitch: CustomSwitch) {
    // Обновление UI или другие действия при изменении состояния переключателя
}
```
