import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:flappy_flame/game/flappy_game.dart';

class Ground extends PositionComponent with HasGameRef<FlappyGame>, CollisionCallbacks {
  static const double groundHeight = 100;
  static const double scrollSpeed = 200;

  @override
  Future<void> onLoad() async {
    size = Vector2(gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = const Color(0xFF8B4513);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);

    final grassPaint = Paint()..color = const Color(0xFF228B22);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, 15), grassPaint);

    final linePaint = Paint()
      ..color = const Color(0xFF654321)
      ..strokeWidth = 2;
    for (double i = 0; i < size.x; i += 40) {
      canvas.drawLine(Offset(i, 15), Offset(i, size.y), linePaint);
    }
  }
}
