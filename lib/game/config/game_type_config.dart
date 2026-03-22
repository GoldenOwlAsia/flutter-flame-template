import 'package:flutter/material.dart';

import '../my_casual_game.dart';

/// Color scheme for 3D game selection cards.
class GameCardColors {
  const GameCardColors({
    required this.top,
    required this.mid,
    required this.bottom,
    required this.bevel,
  });

  final Color top;
  final Color mid;
  final Color bottom;
  final Color bevel;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameCardColors &&
          top == other.top &&
          mid == other.mid &&
          bottom == other.bottom &&
          bevel == other.bevel;

  @override
  int get hashCode => Object.hash(top, mid, bottom, bevel);
}

/// Config per GameType: display name, icon, and card colors.
extension GameTypeConfig on GameType {
  String get displayName => switch (this) {
        GameType.tap => 'Tap Game',
        GameType.tap2 => 'Tap Game 2',
        GameType.tap3 => 'Tap Game 3',
        GameType.colorMatch => 'Color Match',
      };

  String get iconPath => switch (this) {
        GameType.tap => 'assets/images/ic_tap.png',
        GameType.tap2 => 'assets/images/ic_tap_2.png',
        GameType.tap3 => 'assets/images/ic_tap_3.png',
        GameType.colorMatch => 'assets/images/ic_color.png',
      };

  GameCardColors get cardColors => switch (this) {
        GameType.tap => const GameCardColors(
          top: Color(0xFF66BB6A),
          mid: Color(0xFF43A047),
          bottom: Color(0xFF2E7D32),
          bevel: Color(0xFF1B5E20),
        ),
        GameType.tap2 => const GameCardColors(
          top: Color(0xFFFFB74D),
          mid: Color(0xFFFB8C00),
          bottom: Color(0xFFE65100),
          bevel: Color(0xFFBF360C),
        ),
        GameType.tap3 => const GameCardColors(
          top: Color(0xFFAB47BC),
          mid: Color(0xFF8E24AA),
          bottom: Color(0xFF6A1B9A),
          bevel: Color(0xFF4A148C),
        ),
        GameType.colorMatch => const GameCardColors(
          top: Color(0xFF42A5F5),
          mid: Color(0xFF1E88E5),
          bottom: Color(0xFF1565C0),
          bevel: Color(0xFF0D47A1),
        ),
      };
}
