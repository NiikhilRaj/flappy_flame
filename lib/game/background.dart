import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flappy_flame/game/flappy_game.dart';

class GameBackground extends PositionComponent with HasGameRef<FlappyGame> {
  @override
  Future<void> onLoad() async {
    size = gameRef.size;
    position = Vector2.zero();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF87CEEB),
        const Color(0xFF4A90E2),
      ],
    );
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    final cloudPaint = Paint()..color = Colors.white.withValues(alpha: 0.6);
    canvas.drawCircle(const Offset(100, 100), 30, cloudPaint);
    canvas.drawCircle(const Offset(130, 100), 40, cloudPaint);
    canvas.drawCircle(const Offset(160, 100), 30, cloudPaint);

    canvas.drawCircle(const Offset(300, 180), 35, cloudPaint);
    canvas.drawCircle(const Offset(335, 180), 45, cloudPaint);
    canvas.drawCircle(const Offset(370, 180), 35, cloudPaint);
  }
}
