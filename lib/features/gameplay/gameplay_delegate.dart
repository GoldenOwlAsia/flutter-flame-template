import 'package:flame/components.dart';

abstract class GameplayDelegate extends PositionComponent {
  final void Function(bool isWin, int score) onGameOver;
  final void Function(int score) onScoreUpdated;

  GameplayDelegate({required this.onGameOver, required this.onScoreUpdated});

  void onGameStart() {}
  void onGamePause() {}
  void onGameResume() {}
  void reset();
}
