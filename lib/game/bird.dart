import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:flappy_flame/game/flappy_game.dart';

class Bird extends PositionComponent with HasGameRef<FlappyGame>, CollisionCallbacks {
  static const double gravity = 1200;
  static const double jumpVelocity = -400;
  static const double birdSize = 40;

  double velocity = 0;
  bool isAlive = true;

  @override
  Future<void> onLoad() async {
    size = Vector2.all(birdSize);
    position = Vector2(100, gameRef.size.y / 2);
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isAlive) return;

    velocity += gravity * dt;
    position.y += velocity * dt;

    if (position.y > gameRef.size.y - birdSize / 2 || position.y < birdSize / 2) {
      gameRef.gameOver();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = const Color(0xFFFFD700);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), birdSize / 2, paint);
    
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(size.x / 2 + 8, size.y / 2 - 5), 4, eyePaint);
    
    final beakPaint = Paint()..color = const Color(0xFFFF8C00);
    final beakPath = Path()
      ..moveTo(size.x / 2 + 15, size.y / 2)
      ..lineTo(size.x / 2 + 25, size.y / 2 - 3)
      ..lineTo(size.x / 2 + 25, size.y / 2 + 3)
      ..close();
    canvas.drawPath(beakPath, beakPaint);
  }

  void jump() {
    if (isAlive) {
      velocity = jumpVelocity;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (isAlive) {
      gameRef.gameOver();
    }
  }

  void reset() {
    position = Vector2(100, gameRef.size.y / 2);
    velocity = 0;
    isAlive = true;
  }
}
