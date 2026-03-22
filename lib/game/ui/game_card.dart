import 'package:flutter/material.dart';

import '../config/game_type_config.dart';
import '../my_casual_game.dart';

const _shadowColor = Color(0x40000000);
const _shadowBlur = 6.0;
const _radius = 20.0;

/// 3D square card for game selection: icon on top, name below.
/// Mirrors [menu_button] 3D style (gradient face, bevel, drop shadow).
class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.gameType,
    required this.onTap,
    this.size = 160,
  });

  final GameType gameType;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = gameType.cardColors;
    final bevelHeight = size * 0.15;
    final faceHeight = size - bevelHeight;
    final iconSize = size * 0.4; // Icon ~40% of card
    final iconTop = size * 0.30; // Icon anchored at top 30%, overlaps above

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              size: Size(size, size),
              painter: _GameCardPainter(
                colors: colors,
                bevelHeight: bevelHeight,
                faceHeight: faceHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: size * 0.38), // Spacer for icon area
                    Expanded(
                      child: Center(
                        child: Text(
                          gameType.displayName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFFF8E1),
                            shadows: [
                              Shadow(
                                color: colors.bevel.withValues(alpha: 0.8),
                                offset: const Offset(2, 2),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Icon overlay at top 30%, overflowing outside top
            Positioned(
              top: iconTop - iconSize, // Bottom of icon at 30%, so it extends above
              left: (size - iconSize) / 2,
              child: SizedBox(
                width: iconSize,
                height: iconSize,
                child: Image.asset(
                  gameType.iconPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameCardPainter extends CustomPainter {
  _GameCardPainter({
    required this.colors,
    required this.bevelHeight,
    required this.faceHeight,
  });

  final GameCardColors colors;
  final double bevelHeight;
  final double faceHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Box shadow (soft drop shadow)
    final shadowRect = rect.shift(const Offset(0, 4));
    final shadowRRect = RRect.fromRectAndRadius(
      shadowRect,
      const Radius.circular(_radius),
    );
    canvas.drawRRect(
      shadowRRect,
      Paint()
        ..color = _shadowColor
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, _shadowBlur),
    );

    // 3D bevel (dark bottom edge ~15% height)
    final bevelRect = Rect.fromLTWH(
      0,
      size.height - bevelHeight,
      size.width,
      bevelHeight,
    );
    final bevelRRect = RRect.fromRectAndCorners(
      bevelRect,
      bottomLeft: const Radius.circular(_radius),
      bottomRight: const Radius.circular(_radius),
    );
    canvas.drawRRect(bevelRRect, Paint()..color = colors.bevel);

    // Main face (gradient)
    final faceRect = Rect.fromLTWH(0, 0, size.width, faceHeight);
    final faceRRect = RRect.fromRectAndCorners(
      faceRect,
      topLeft: const Radius.circular(_radius),
      topRight: const Radius.circular(_radius),
    );
    canvas.drawRRect(
      faceRRect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.top, colors.mid, colors.bottom],
        ).createShader(faceRect),
    );
  }

  @override
  bool shouldRepaint(covariant _GameCardPainter oldDelegate) =>
      oldDelegate.colors != colors ||
      oldDelegate.bevelHeight != bevelHeight ||
      oldDelegate.faceHeight != faceHeight;
}
