import 'dart:async';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flappy_flame/game/bird.dart';
import 'package:flappy_flame/game/pipe.dart';
import 'package:flappy_flame/game/ground.dart';
import 'package:flappy_flame/game/background.dart';
import 'package:flappy_flame/services/score_service.dart';

enum GameState { menu, playing, gameOver }

class FlappyGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Ground ground;
  late GameBackground background;
  
  GameState gameState = GameState.menu;
  int score = 0;
  int highScore = 0;
  
  final ScoreService scoreService = ScoreService();
  Timer? pipeSpawnTimer;
  
  Function(int, int)? onScoreUpdate;
  Function()? onGameOverCallback;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    highScore = await scoreService.getHighScore();
    
    background = GameBackground();
    add(background);

    bird = Bird();
    add(bird);

    ground = Ground();
    add(ground);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameState == GameState.playing) {
      pipeSpawnTimer?.update(dt);
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (gameState == GameState.playing) {
      bird.jump();
    } else if (gameState == GameState.menu) {
      startGame();
    }
  }

  void startGame() {
    gameState = GameState.playing;
    score = 0;
    bird.reset();
    
    children.whereType<PipePair>().forEach((pipe) => pipe.removeFromParent());
    
    pipeSpawnTimer = Timer(
      2.0,
      repeat: true,
      onTick: spawnPipe,
    );
    
    onScoreUpdate?.call(score, highScore);
  }

  void spawnPipe() {
    final pipe = PipePair(xPosition: size.x);
    add(pipe);
  }

  void incrementScore() {
    score++;
    if (score > highScore) {
      highScore = score;
    }
    onScoreUpdate?.call(score, highScore);
  }

  void gameOver() {
    gameState = GameState.gameOver;
    bird.isAlive = false;
    pipeSpawnTimer?.stop();
    scoreService.saveHighScore(score);
    onGameOverCallback?.call();
  }

  void resetGame() {
    gameState = GameState.menu;
    score = 0;
    bird.reset();
    children.whereType<PipePair>().forEach((pipe) => pipe.removeFromParent());
    pipeSpawnTimer?.stop();
    onScoreUpdate?.call(score, highScore);
  }
}
