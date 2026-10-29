# GwentGame

<p align="center">
  <img src="https://github.com/IgorChumikov/GwentGame/assets/73794638/16f48a41-9761-4c4e-9ee7-af517f1aa1b9" width="300" alt="GwentGame gameplay screenshot">
</p>

## English

GwentGame is a small single-player card game for iOS inspired by Gwent. Build your army, play cards with different strength values, and outscore the computer over three rounds.

### Gameplay

- Both the player and the computer start with five randomly drawn cards.
- Each card adds 1, 2, 4, or 6 points to the army's total strength.
- Play a card, then pass the turn to let the computer make its move.
- You may pass for the rest of the round when you are satisfied with your score.
- The side with the higher total strength wins the round; a tie awards a round win to both sides.
- Three additional cards are drawn between rounds while cards remain in the deck.
- The player with the most round victories after three rounds wins the game.

### Features

- Native SwiftUI interface
- Computer opponent with randomized moves and pass decisions
- Three-round match flow with automatic scoring and restart
- Separate hand, deck, and battlefield presentation
- MVVM-based game logic with protocol-driven dependency injection
- Unit tests for the initial state and core player actions

### Tech stack

- Swift 5
- SwiftUI
- Combine (`ObservableObject` and `@Published`)
- XCTest
- MVVM

### Requirements

- Xcode 14.2 or newer
- iOS 16.2 or newer
- iPhone or iPad simulator/device

### Getting started

1. Clone the repository:

   ```bash
   git clone https://github.com/IgorChumikov/GwentGame.git
   ```

2. Open `GwentGame.xcodeproj` in Xcode.
3. Select the `GwentGame` scheme and an iOS simulator or connected device.
4. Press **Run** (`⌘R`).

To run the unit tests, press **Test** (`⌘U`) in Xcode.

### Project structure

```text
GwentGame/
├── Assembly/      # View-model construction
├── Helpers/       # Observable-object type erasure and property wrappers
├── Model/         # Card and card-value models
├── ViewModels/    # Game state and rules
├── Views/         # SwiftUI screens and reusable game views
└── Assets.xcassets

GameViewModelTests/ # Unit tests for game logic
```

---

## Русский

GwentGame — небольшая однопользовательская карточная игра для iOS, вдохновлённая «Гвинтом». Собирайте отряд, разыгрывайте карты с разной силой и постарайтесь превзойти компьютер по итогам трёх раундов.

### Игровой процесс

- Игрок и компьютер начинают матч с пятью случайными картами на руке.
- Каждая карта добавляет к общей силе отряда 1, 2, 4 или 6 очков.
- Разыграйте карту и передайте ход компьютеру.
- Если набранных очков достаточно, можно спасовать до конца раунда.
- Раунд выигрывает сторона с большей суммарной силой; при ничьей победа засчитывается обеим сторонам.
- Между раундами каждый участник получает ещё по три карты, пока они остаются в колоде.
- Победителем матча становится тот, кто выиграл больше раундов из трёх.

### Возможности

- Нативный интерфейс на SwiftUI
- Компьютерный соперник со случайным выбором ходов и решения о пасе
- Матч из трёх раундов с автоматическим подсчётом результата и перезапуском
- Отдельное отображение руки, колоды и поля боя
- Игровая логика на основе MVVM и внедрение зависимостей через протокол
- Модульные тесты начального состояния и основных действий игрока

### Технологии

- Swift 5
- SwiftUI
- Combine (`ObservableObject` и `@Published`)
- XCTest
- MVVM

### Требования

- Xcode 14.2 или новее
- iOS 16.2 или новее
- Симулятор либо устройство iPhone или iPad

### Запуск проекта

1. Клонируйте репозиторий:

   ```bash
   git clone https://github.com/IgorChumikov/GwentGame.git
   ```

2. Откройте `GwentGame.xcodeproj` в Xcode.
3. Выберите схему `GwentGame` и симулятор iOS либо подключённое устройство.
4. Нажмите **Run** (`⌘R`).

Для запуска модульных тестов нажмите **Test** (`⌘U`) в Xcode.

### Структура проекта

```text
GwentGame/
├── Assembly/      # Сборка модели представления
├── Helpers/       # Type erasure для ObservableObject и property wrappers
├── Model/         # Модели карт и их силы
├── ViewModels/    # Состояние игры и игровые правила
├── Views/         # Экраны SwiftUI и переиспользуемые игровые представления
└── Assets.xcassets

GameViewModelTests/ # Модульные тесты игровой логики
```

