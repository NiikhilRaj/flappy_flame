import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverlay extends StatelessWidget {
  final int score;
  final int highScore;
  final bool isGameOver;
  final bool isPlaying;
  final VoidCallback onRestart;
  final VoidCallback onBack;

  const GameOverlay({
    super.key,
    required this.score,
    required this.highScore,
    required this.isGameOver,
    required this.isPlaying,
    required this.onRestart,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isPlaying)
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '$score',
                style: GoogleFonts.pressStart2p(
                  fontSize: 48,
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                      color: Color(0xFF2C3E50),
                      offset: Offset(3, 3),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (!isPlaying && !isGameOver)
          Positioned.fill(
            child: Center(
              child: Text(
                'TAP TO START',
                style: GoogleFonts.pressStart2p(
                  fontSize: 24,
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                      color: Color(0xFF2C3E50),
                      offset: Offset(3, 3),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (isGameOver)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFFFFF), Color(0xFFF0F0F0)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        offset: const Offset(0, 8),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'GAME OVER',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 28,
                          color: const Color(0xFFFF6B6B),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'SCORE',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 14,
                                  color: const Color(0xFF4A90E2),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$score',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 32,
                                  color: const Color(0xFF2C3E50),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'BEST',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 14,
                                  color: const Color(0xFF4A90E2),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$highScore',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 32,
                                  color: const Color(0xFFFFD700),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: onBack,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'MENU',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: onRestart,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'RETRY',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
