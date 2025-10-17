import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flappy_flame/screens/game_screen.dart';
import 'package:flappy_flame/services/score_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScoreService _scoreService = ScoreService();
  int _highScore = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final score = await _scoreService.getHighScore();
    setState(() => _highScore = score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF87CEEB), Color(0xFF4A90E2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FLAPPY',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        color: Color(0xFF2C3E50),
                        offset: Offset(4, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'BIRD',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFD700),
                    shadows: [
                      const Shadow(
                        color: Color(0xFF2C3E50),
                        offset: Offset(4, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GameScreen()),
                    ).then((_) => _loadHighScore());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          offset: const Offset(0, 6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Text(
                      'START',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'HIGH SCORE',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 16,
                          color: const Color(0xFF4A90E2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_highScore',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 36,
                          color: const Color(0xFFFF6B6B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
