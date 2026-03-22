import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerComponent extends PositionComponent {
  PlayerComponent() : super(size: Vector2.all(50), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    // Add visual representation, e.g., a sprite or rectangle
    add(RectangleComponent(size: size, paint: Paint()..color = Colors.blue));
    return super.onLoad();
  }
}
