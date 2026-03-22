import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../my_casual_game.dart';
import '../ui/menu_button.dart';
import '../../core/di/locator.dart';
import '../../core/storage/local_storage.dart';

class IntroRoute extends Component with HasGameReference<MyCasualGame> {
  @override
  Future<void> onLoad() async {
    final sprite = await game.loadSprite('images/landing.png');
    final background = SpriteComponent(sprite: sprite);
    final srcSize = sprite.srcSize;
    final size = game.size;
    final scaleX = size.x / srcSize.x;
    final scaleY = size.y / srcSize.y;
    final coverScale = scaleX > scaleY ? scaleX : scaleY;
    background
      ..size = Vector2(srcSize.x * coverScale, srcSize.y * coverScale)
      ..position = size / 2
      ..anchor = Anchor.center;
    add(background);

    add(ContinueButton(size: game.size));
    add(TapToContinueButton(size: Vector2(220, 56)));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    children.whereType<SpriteComponent>().forEach((bg) {
      final sprite = bg.sprite;
      if (sprite == null) return;
      final srcSize = sprite.srcSize;
      final scaleX = size.x / srcSize.x;
      final scaleY = size.y / srcSize.y;
      final coverScale = scaleX > scaleY ? scaleX : scaleY;
      bg
        ..size = Vector2(srcSize.x * coverScale, srcSize.y * coverScale)
        ..position = size / 2
        ..anchor = Anchor.center;
    });
    children.whereType<TapToContinueButton>().forEach(
          (b) => b.position = Vector2(size.x / 2, size.y * 0.85),
        );
    children.whereType<ContinueButton>().forEach(
          (b) => b..size = size..position = Vector2.zero(),
        );
  }
}

class TapToContinueButton extends MenuButton with HasGameReference<MyCasualGame> {
  TapToContinueButton({required super.size})
      : super(text: 'Tap to continue', style: MenuButtonStyle.primary, fontSize: 20);

  @override
  void onTap() {
    getIt<LocalStorage>().setFirstTime(false);
    game.router.pushReplacementNamed('select_game');
  }
}

class ContinueButton extends PositionComponent
    with TapCallbacks, HasGameReference<MyCasualGame> {
  ContinueButton({required Vector2 size}) : super(size: size);

  @override
  void onTapDown(TapDownEvent event) {
    getIt<LocalStorage>().setFirstTime(false);
    game.router.pushReplacementNamed('select_game');
  }
}
