import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BackgroundComponent extends PositionComponent {
  BackgroundComponent() : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    // Provide a basic background color
    add(RectangleComponent(size: size, paint: Paint()..color = Colors.grey.shade900));
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    this.size = size;
    position = size / 2;
    super.onGameResize(size);
  }
}
