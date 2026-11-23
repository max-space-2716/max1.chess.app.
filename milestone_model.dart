enum MilestoneCategory { rating, titleNorm, tournamentPerformance, tacticalMastery, repertoireDepth }

class MilestoneModel {
  final String milestoneId;
  final String userId;
  final String title;
  final String description;
  final MilestoneCategory category;
  final int targetValue;
  final int currentValue;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const MilestoneModel({
    required this.milestoneId,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.targetValue,
    required this.currentValue,
    required this.isUnlocked,
    this.unlockedAt,
  });

  Map<String, dynamic> toJson() => {
        'milestoneId': milestoneId,
        'userId': userId,
        'title': title,
        'description': description,
        'category': category.name,
        'targetValue': targetValue,
        'currentValue': currentValue,
        'isUnlocked': isUnlocked,
        'unlockedAt': unlockedAt?.toIso8601String(),
      };

  factory MilestoneModel.fromJson(Map<String, dynamic> json) => MilestoneModel(
        milestoneId: json['milestoneId'] as String,
        userId: json['userId'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: MilestoneCategory.values.firstWhere(
          (e) => e.name == json['category'],
          orElse: () => MilestoneCategory.rating,
        ),
        targetValue: json['targetValue'] as int,
        currentValue: json['currentValue'] as int,
        isUnlocked: json['isUnlocked'] as bool? ?? false,
        unlockedAt: json['unlockedAt'] != null ? DateTime.parse(json['unlockedAt'] as String) : null,
      );
}
