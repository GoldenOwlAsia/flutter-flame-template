import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../gameplay_delegate.dart';

class TapGameDelegate extends GameplayDelegate with TapCallbacks {
  late RectangleComponent targetSquare;
  final Random _random = Random();
  int _currentScore = 0;

  TapGameDelegate({required super.onGameOver, required super.onScoreUpdated});

  @override
  Future<void> onLoad() async {
    targetSquare = RectangleComponent(
      size: Vector2.all(80),
      paint: Paint()..color = Colors.red,
    );
    add(targetSquare);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
    _moveTarget();
  }

  @override
  void reset() {
    _currentScore = 0;
    onScoreUpdated(_currentScore);
    _moveTarget();
  }

  void _moveTarget() {
    if (size.x <= 80 || size.y <= 80) return;
    targetSquare.position = Vector2(
      _random.nextDouble() * (size.x - 80),
      _random.nextDouble() * (size.y - 80),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (targetSquare.toRect().contains(event.localPosition.toOffset())) {
      _currentScore++;
      onScoreUpdated(_currentScore);
      if (_currentScore >= 10) {
        onGameOver(true, _currentScore);
      } else {
        _moveTarget();
      }
    } else {
      onGameOver(false, _currentScore);
    }
  }
}
