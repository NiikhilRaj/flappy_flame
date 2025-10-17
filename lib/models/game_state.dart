class GameScore {
  final int currentScore;
  final int highScore;
  final DateTime lastPlayed;

  GameScore({
    required this.currentScore,
    required this.highScore,
    required this.lastPlayed,
  });

  GameScore copyWith({
    int? currentScore,
    int? highScore,
    DateTime? lastPlayed,
  }) => GameScore(
    currentScore: currentScore ?? this.currentScore,
    highScore: highScore ?? this.highScore,
    lastPlayed: lastPlayed ?? this.lastPlayed,
  );

  Map<String, dynamic> toJson() => {
    'currentScore': currentScore,
    'highScore': highScore,
    'lastPlayed': lastPlayed.toIso8601String(),
  };

  factory GameScore.fromJson(Map<String, dynamic> json) => GameScore(
    currentScore: json['currentScore'] as int,
    highScore: json['highScore'] as int,
    lastPlayed: DateTime.parse(json['lastPlayed'] as String),
  );
}
