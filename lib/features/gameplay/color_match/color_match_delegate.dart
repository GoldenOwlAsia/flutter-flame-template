import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../gameplay_delegate.dart';

class ColorMatchDelegate extends GameplayDelegate {
  final Random _random = Random();
  int _currentLevel = 1;
  double _timeRemaining = 3.0;
  bool _isPlaying = false;
  late TextComponent _timerText;

  ColorMatchDelegate({
    required super.onGameOver,
    required super.onScoreUpdated,
  });

  @override
  Future<void> onLoad() async {
    _timerText = TextComponent(
      text: '3.0s',
      position: Vector2(20, 60),
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
    add(_timerText);
  }

  @override
  void reset() {
    _currentLevel = 1;
    _timeRemaining = 3.0;
    _isPlaying = true;
    onScoreUpdated(_currentLevel - 1);
    if (size.x > 0 && size.y > 0) {
      _generateBoard();
    } else {
      children.whereType<ColorTile>().toList().forEach(
        (c) => c.removeFromParent(),
      );
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
    if (_isPlaying) {
      _generateBoard();
    }
  }

  void _generateBoard() {
    children.whereType<ColorTile>().toList().forEach(
      (c) => c.removeFromParent(),
    );

    int gridSize = _getGridSize(_currentLevel);

    int r = _random.nextInt(200);
    int g = _random.nextInt(200);
    int b = _random.nextInt(200);
    Color baseColor = Color.fromARGB(255, r, g, b);

    int diff = max(10, 50 - (_currentLevel * 2));
    Color diffColor = Color.fromARGB(255, r + diff, g + diff, b + diff);

    int diffIndex = _random.nextInt(gridSize * gridSize);

    double boardSize = min(size.x, size.y) - 60;
    if (boardSize <= 0) return;

    double padding = 4.0;
    double tileSize = (boardSize - (padding * (gridSize - 1))) / gridSize;

    Vector2 startOffset = Vector2(
      (size.x - boardSize) / 2,
      (size.y - boardSize) / 2 + 40,
    );

    for (int i = 0; i < gridSize * gridSize; i++) {
      int row = i ~/ gridSize;
      int col = i % gridSize;
      Vector2 pos =
          startOffset +
          Vector2(col * (tileSize + padding), row * (tileSize + padding));

      bool isDiff = (i == diffIndex);
      add(
        ColorTile(
          position: pos,
          size: Vector2.all(tileSize),
          color: isDiff ? diffColor : baseColor,
          isDifferent: isDiff,
          onTap: (correct) {
            if (!_isPlaying) return;
            if (correct) {
              _currentLevel++;
              _timeRemaining = 3.0; // Reset timer
              onScoreUpdated(_currentLevel - 1);
              _generateBoard();
            } else {
              _isPlaying = false;
              onGameOver(false, _currentLevel - 1);
            }
          },
        ),
      );
    }
  }

  int _getGridSize(int level) {
    if (level <= 3) return 2;
    if (level <= 6) return 4;
    if (level <= 9) return 5;
    if (level <= 12) return 6;
    if (level <= 15) return 7;
    if (level <= 18) return 8;
    if (level <= 21) return 9;
    return 10;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isPlaying) {
      _timeRemaining -= dt;
      if (_timeRemaining <= 0) {
        _timeRemaining = 0;
        _isPlaying = false;
        onGameOver(false, _currentLevel - 1);
      }
      _timerText.text = '${_timeRemaining.toStringAsFixed(1)}s';
    }
  }
}

class ColorTile extends PositionComponent with TapCallbacks {
  final Color color;
  final bool isDifferent;
  final void Function(bool) onTap;

  ColorTile({
    required super.position,
    required super.size,
    required this.color,
    required this.isDifferent,
    required this.onTap,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8)),
      Paint()..color = color,
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap(isDifferent);
  }
}
