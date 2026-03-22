import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import '../my_casual_game.dart';
import '../ui/background_gradient.dart';
import '../ui/menu_button.dart';

class PauseRoute extends Component with HasGameReference<MyCasualGame> {
  late TextComponent _titleText;
  late DimOverlay _overlay;

  @override
  Future<void> onLoad() async {
    _overlay = DimOverlay();
    add(_overlay);

    _titleText = TextComponent(
      text: 'PAUSED',
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 36,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: Color(0x80000000), offset: Offset(2, 2), blurRadius: 4),
            Shadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 8),
          ],
        ),
      ),
    );
    add(_titleText);
    add(PauseResumeButton(size: Vector2(220, 56)));
    add(PauseRestartButton(size: Vector2(220, 56)));
    add(PauseMainMenuButton(size: Vector2(200, 48)));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _overlay
      ..size = size
      ..position = Vector2.zero();
    _titleText.position = size / 2 - Vector2(0, 80);
    children.whereType<PauseResumeButton>().forEach(
      (b) => b.position = size / 2 + Vector2(0, 10),
    );
    children.whereType<PauseRestartButton>().forEach(
      (b) => b.position = size / 2 + Vector2(0, 76),
    );
    children.whereType<PauseMainMenuButton>().forEach(
      (b) => b.position = size / 2 + Vector2(0, 142),
    );
  }
}

class PauseResumeButton extends MenuButton with HasGameReference<MyCasualGame> {
  PauseResumeButton({required super.size})
      : super(text: 'Resume', style: MenuButtonStyle.primary, fontSize: 24);

  @override
  void onTap() {
    game.router.pop();
  }
}

class PauseRestartButton extends MenuButton with HasGameReference<MyCasualGame> {
  PauseRestartButton({required super.size})
      : super(text: 'Restart', style: MenuButtonStyle.primary, fontSize: 24);

  @override
  void onTap() {
    game.router.pop();
    game.router.pushReplacementNamed('play');
  }
}

class PauseMainMenuButton extends MenuButton with HasGameReference<MyCasualGame> {
  PauseMainMenuButton({required super.size})
      : super(text: 'Main Menu', style: MenuButtonStyle.secondary, fontSize: 20);

  @override
  void onTap() {
    game.router.pop();
    game.router.pushReplacementNamed('menu');
  }
}
