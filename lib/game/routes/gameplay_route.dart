import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../my_casual_game.dart';
import '../../features/gameplay/gameplay_delegate.dart';
import '../../features/gameplay/tap_game/tap_game_delegate.dart';
import '../../features/gameplay/tap_game_2/tap_game_2_delegate.dart';
import '../../features/gameplay/tap_game_3/tap_game_3_delegate.dart';
import '../../features/gameplay/color_match/color_match_delegate.dart';

class GameplayRoute extends Component with HasGameReference<MyCasualGame> {
  late TextComponent scoreText;
  late GameplayDelegate delegate;

  @override
  Future<void> onLoad() async {
    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 20),
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );

    void onGameOverCB(bool isWin, int score) {
      game.lastScore = score;
      game.lastGameWon = isWin;
      game.router.pushReplacementNamed('game_over');
    }

    switch (game.selectedGameType) {
      case GameType.tap:
        delegate = TapGameDelegate(
          onGameOver: onGameOverCB,
          onScoreUpdated: (score) => scoreText.text = 'Score: $score',
        );
        break;
      case GameType.tap2:
        delegate = TapGame2Delegate(
          onGameOver: onGameOverCB,
          onScoreUpdated: (score) => scoreText.text = 'Score: $score',
        );
        break;
      case GameType.tap3:
        delegate = TapGame3Delegate(
          onGameOver: onGameOverCB,
          onScoreUpdated: (score) => scoreText.text = 'Score: $score',
        );
        break;
      case GameType.colorMatch:
        delegate = ColorMatchDelegate(
          onGameOver: onGameOverCB,
          onScoreUpdated: (score) => scoreText.text = 'Level: ${score + 1}',
        );
        break;
    }

    add(delegate);
    add(scoreText);
    add(PauseButton(position: Vector2(game.size.x - 60, 20)));
  }

  @override
  void onMount() {
    super.onMount();
    delegate.reset();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    delegate.size = size;
    children.whereType<PauseButton>().forEach((b) {
      if (size.x > 60) {
        b.position = Vector2(size.x - 60, 20);
      }
    });
  }
}

class PauseButton extends PositionComponent
    with TapCallbacks, HasGameReference<MyCasualGame> {
  PauseButton({required Vector2 position})
    : super(position: position, size: Vector2.all(40));

  @override
  Future<void> onLoad() async {
    add(TextComponent(text: 'II', position: size / 2, anchor: Anchor.center));
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.router.pushNamed('pause');
  }
}
