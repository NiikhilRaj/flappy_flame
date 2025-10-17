import 'package:shared_preferences/shared_preferences.dart';

class ScoreService {
  static const String _highScoreKey = 'high_score';

  Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_highScoreKey) ?? 0;
  }

  Future<void> saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final currentHighScore = await getHighScore();
    if (score > currentHighScore) {
      await prefs.setInt(_highScoreKey, score);
    }
  }

  Future<void> resetHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_highScoreKey);
  }
}
