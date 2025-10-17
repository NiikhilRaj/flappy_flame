import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:flappy_flame/game/flappy_game.dart';

class PipePair extends PositionComponent with HasGameRef<FlappyGame> {
  static const double pipeWidth = 80;
  static const double gapHeight = 200;
  static const double scrollSpeed = 200;
  
  bool scored = false;

  PipePair({required double xPosition}) {
    position = Vector2(xPosition, 0);
  }

  @override
  Future<void> onLoad() async {
    final random = Random();
    final screenHeight = gameRef.size.y;
    final minGapY = 150.0;
    final maxGapY = screenHeight - 150 - gapHeight;
    final gapY = minGapY + random.nextDouble() * (maxGapY - minGapY);

    final topPipe = Pipe(
      width: pipeWidth,
      height: gapY,
      isTop: true,
    );
    topPipe.position = Vector2(0, 0);
    add(topPipe);

    final bottomPipe = Pipe(
      width: pipeWidth,
      height: screenHeight - gapY - gapHeight,
      isTop: false,
    );
    bottomPipe.position = Vector2(0, gapY + gapHeight);
    add(bottomPipe);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= scrollSpeed * dt;

    if (!scored && position.x + pipeWidth < gameRef.bird.position.x) {
      scored = true;
      gameRef.incrementScore();
    }

    if (position.x < -pipeWidth) {
      removeFromParent();
    }
  }
}

class Pipe extends PositionComponent with CollisionCallbacks {
  final double width;
  final double height;
  final bool isTop;

  Pipe({required this.width, required this.height, required this.isTop});

  @override
  Future<void> onLoad() async {
    size = Vector2(width, height);
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final bodyPaint = Paint()..color = const Color(0xFF2ECC71);
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), bodyPaint);

    final borderPaint = Paint()
      ..color = const Color(0xFF27AE60)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderPaint);

    if (isTop) {
      final capRect = Rect.fromLTWH(-5, height - 30, width + 10, 30);
      canvas.drawRect(capRect, bodyPaint);
      canvas.drawRect(capRect, borderPaint);
    } else {
      final capRect = Rect.fromLTWH(-5, 0, width + 10, 30);
      canvas.drawRect(capRect, bodyPaint);
      canvas.drawRect(capRect, borderPaint);
    }
  }
}
