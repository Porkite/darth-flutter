class GameSettings {
  final String playerImg;
  final String backgroundImg;
  final String itemImg;
  final int targetScore;
  final int maxAttempts;
  GameSettings(
      {required this.playerImg,
        required this.backgroundImg,
        required this.itemImg,
        required this.targetScore,
        required this.maxAttempts,
      });

  factory GameSettings.fromJson(Map<String, dynamic> json) {
    return GameSettings(
        playerImg: json['playerImg'],
        backgroundImg: json['backgroundImg'],
        itemImg: json['itemImg'],
        targetScore: json['targetScore'],
        maxAttempts: json['maxAttempts']
    );
  }
}