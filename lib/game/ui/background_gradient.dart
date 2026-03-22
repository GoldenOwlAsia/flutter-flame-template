import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

/// Callback to resolve gradient colors each frame. Used when colors can change
/// (e.g. menu reused after selecting a different game).
typedef GradientColorsResolver = List<Color> Function();

/// Full-screen gradient background for menu screens.
/// Uses [colors] when provided, or [colorsResolver] for dynamic colors (e.g. from current game type).
/// If neither is provided, uses a dark default.
class BackgroundGradient extends PositionComponent {
  BackgroundGradient({List<Color>? colors, GradientColorsResolver? colorsResolver})
      : _colors = colors,
        _colorsResolver = colorsResolver,
        _defaultColors = const [
          Color(0xFF2C3E50),
          Color(0xFF1A252F),
          Color(0xFF0D1117),
        ];

  final List<Color>? _colors;
  final GradientColorsResolver? _colorsResolver;
  final List<Color> _defaultColors;

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    final gradientColors = switch ((_colorsResolver, _colors)) {
      (GradientColorsResolver f, _) => f(),
      (_, List<Color> c) => c,
      _ => _defaultColors,
    };
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ).createShader(rect),
    );
  }
}

/// Semi-transparent dark overlay for pause overlay.
/// Renders over the paused game so it remains faintly visible underneath.
class DimOverlay extends PositionComponent {
  DimOverlay({this.opacity = 0.7});

  final double opacity;

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(
      rect,
      Paint()..color = Color.fromRGBO(0, 0, 0, opacity),
    );
  }
}
