import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flappy_flame/game/flappy_game.dart';
import 'package:flappy_flame/widgets/game_overlay.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late FlappyGame _game;
  int _score = 0;
  int _highScore = 0;
  bool _showGameOver = false;

  @override
  void initState() {
    super.initState();
    _game = FlappyGame()
      ..onScoreUpdate = _updateScore
      ..onGameOverCallback = _handleGameOver;
  }

  void _updateScore(int score, int highScore) {
    setState(() {
      _score = score;
      _highScore = highScore;
    });
  }

  void _handleGameOver() {
    setState(() => _showGameOver = true);
  }

  void _restartGame() {
    setState(() => _showGameOver = false);
    _game.resetGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: _game),
          GameOverlay(
            score: _score,
            highScore: _highScore,
            isGameOver: _showGameOver,
            isPlaying: _game.gameState == GameState.playing,
            onRestart: _restartGame,
            onBack: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
