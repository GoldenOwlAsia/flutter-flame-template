import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import '../my_casual_game.dart';
import '../ui/background_gradient.dart';

class SelectGameRoute extends Component with HasGameReference<MyCasualGame> {
  late TextComponent _titleText;
  late BackgroundGradient _background;

  @override
  Future<void> onLoad() async {
    _background = BackgroundGradient();
    add(_background);

    _titleText = TextComponent(
      text: 'Select Game Mode',
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

    game.overlays.add('select_game');
  }

  @override
  void onRemove() {
    game.overlays.remove('select_game');
    super.onRemove();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _background
      ..size = size
      ..position = Vector2.zero();
    _titleText.position = size / 2 - Vector2(0, 90);
  }
}
