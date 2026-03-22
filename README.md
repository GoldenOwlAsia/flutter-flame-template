# Casual Game Boilerplate

A robust, feature-rich boilerplate for starting casual 2D games using [Flutter](https://flutter.dev/) and [Flame](https://flame-engine.org/). 

This template provides an out-of-the-box architecture for routing, state management, dependency injection, audio, persistence, and localization—saving you hours of setup time so you can focus immediately on gameplay mechanics.

---

## 🚀 Getting Started

1. **Clone or Download** this repository as the base for your new game.
2. **Setup Dependencies:** Run `flutter pub get`.
3. **Run the App:** Press `F5` in VS Code, or open a terminal and run `flutter run`.

---

## 🏗 Architecture Overview

The boilerplate is structured to clearly separate Flutter-level configuration, global state, and the Flame game engine:

- **`lib/core/`**: Dependency injection (`get_it`), Local Storage (`shared_preferences`), and global constants.
- **`lib/features/`**: Flutter-level features like Settings (sound toggles), Score tracking (`flutter_bloc`), and Audio controllers.
- **`lib/game/`**: The entire Flame game implementation including `FlameGame` instance, router, scenes, and components.
- **`lib/l10n/`**: Localization `.arb` files (`gen_l10n`).

---

## 🛠 How to Reuse Common Features

This template comes with heavy lifting already done. Here is how you use the built-in services natively across Flutter and Flame:

### 1. Audio System
The `AudioController` is globally accessible via `get_it`. It automatically listens to user settings for muting/unmuting so you never have to check settings logic before playing sounds.
- **To play background music:** Place your file in `assets/audio/` and call:
  ```dart
  getIt<AudioController>().playBgm('bgm.mp3');
  ```
- **To play a sound effect:**
  ```dart
  getIt<AudioController>().playSfx('jump.mp3');
  ```
- **Stopping music:** `getIt<AudioController>().stopBgm();`

### 2. Global State & Storage (Settings/Score)
The app uses `flutter_bloc` (`Cubit`) for state, which automatically syncs with device storage via `shared_preferences`.
- **Modify State:**
  ```dart
  // From Flutter UI or passed into Flame:
  context.read<ScoreCubit>().addScore(10);
  context.read<SettingsCubit>().toggleSound();
  ```
Because `MultiBlocProvider` sits at the top of the Flutter widget tree, you can access these states anywhere outside the Flame engine (e.g., in a Flutter-based HUD overlaid on top of the game).

### 3. Localization
The boilerplate uses standard `gen_l10n`.
Add your strings to `lib/l10n/app_en.arb`. Flutter generates the `AppLocalizations` class.
To access translated strings from Flutter Widgets/Overlays:
```dart
Text(AppLocalizations.of(context)!.startGame)
```

### 4. Routing Flow
We manage scenes using Flame's built-in `RouterComponent`.
To switch between scenes (e.g., transition from the Main Menu to Gameplay):
```dart
// Within any Component that has the `HasGameReference<MyCasualGame>` mixin:
game.router.pushReplacementNamed('play');
```
To pause the game:
```dart
// Pushing the pause route natively stops updates to the underlying GameplayRoute
game.router.pushNamed('pause'); 
```

---

## 🎮 Implementing Core Gameplay

When starting a new game, you primarily work within the `lib/game/` directory. Here is the step-by-step approach to modifying this folder:

### Step 1: Preload Key Assets
Before users enter gameplay, make sure heavy assets are loaded inside `LoadingRoute` (`lib/game/routes/loading_route.dart`).
```dart
@override
Future<void> onLoad() async {
  // Load spritesheets and heavy audio upfront here so the game doesn't lag mid-play:
  await Flame.images.loadAll(['player.png', 'enemy_sheet.png']);
  await FlameAudio.audioCache.loadAll(['bgm.mp3', 'jump.mp3']);
  
  // Transition to main menu
  game.router.pushReplacementNamed('menu');
}
```

### Step 2: Build the World in `GameplayRoute`
The `GameplayRoute` (`lib/game/routes/gameplay_route.dart`) acts as your main stage/level manager. You add your background, map, and entity spawners directly to it.
```dart
@override
Future<void> onLoad() async {
  add(BackgroundComponent());
  add(PlayerComponent());
  add(EnemySpawner());
}
```

### Step 3: Create Custom Components
Build your entities inside `lib/game/components/`. Inherit from `PositionComponent`, `SpriteComponent`, or `SpriteAnimationComponent`, and write your specific game loop logic.
```dart
class PlayerComponent extends SpriteComponent with HasGameReference<MyCasualGame> {
  @override
  Future<void> onLoad() async {
    sprite = Flame.images.fromCache('player.png'); // Fetch preloaded asset!
    size = Vector2(50, 50);
    anchor = Anchor.center;
    // Set initial position, add hitbox, etc.
  }

  @override
  void update(double dt) {
    // Process input, update physics, handle gravity!
    position.y += 100 * dt; 
    super.update(dt);
  }
}
```

### Step 4: Handle Game Over
When the player hits an object, runs out of time, or health drops to zero, simply finalize the score and push them to the Game Over scene:
```dart
void onDeath() {
  getIt<AudioController>().playSfx('game_over.mp3');
  game.router.pushReplacementNamed('game_over');
}
```
