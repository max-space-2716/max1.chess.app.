import 'package:cloud_firestore/cloud_firestore.dart';

enum PriorityLevel { low, medium, high, critical }

class CoachingRecommendation {
  final String recommendationId;
  final String title;
  final String description;
  final String category;
  final PriorityLevel priority;
  final List<String> recommendedActionItems;

  const CoachingRecommendation({
    required this.recommendationId,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.recommendedActionItems,
  });

  Map<String, dynamic> toJson() => {
        'recommendationId': recommendationId,
        'title': title,
        'description': description,
        'category': category,
        'priority': priority.name,
        'recommendedActionItems': recommendedActionItems,
      };

  factory CoachingRecommendation.fromJson(Map<String, dynamic> json) =>
      CoachingRecommendation(
        recommendationId: json['recommendationId'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        priority: PriorityLevel.values.firstWhere(
          (e) => e.name == json['priority'],
          orElse: () => PriorityLevel.medium,
        ),
        recommendedActionItems:
            List<String>.from(json['recommendedActionItems'] ?? []),
      );
}

class FocusArea {
  final String areaId;
  final String title;
  final String category;
  final double targetScore;
  final double currentScore;
  final String keyObjective;

  const FocusArea({
    required this.areaId,
    required this.title,
    required this.category,
    required this.targetScore,
    required this.currentScore,
    required this.keyObjective,
  });

  Map<String, dynamic> toJson() => {
        'areaId': areaId,
        'title': title,
        'category': category,
        'targetScore': targetScore,
        'currentScore': currentScore,
        'keyObjective': keyObjective,
      };

  factory FocusArea.fromJson(Map<String, dynamic> json) => FocusArea(
        areaId: json['areaId'] as String,
        title: json['title'] as String,
        category: json['category'] as String,
        targetScore: (json['targetScore'] as num).toDouble(),
        currentScore: (json['currentScore'] as num).toDouble(),
        keyObjective: json['keyObjective'] as String,
      );
}

class CompleteCoachingProfile {
  final String userId;
  final String coachingSummary;
  final List<CoachingRecommendation> recommendations;
  final List<FocusArea> priorityWeaknesses;
  final List<FocusArea> weeklyFocusAreas;
  final List<FocusArea> monthlyFocusAreas;
  final DateTime generatedAt;

  const CompleteCoachingProfile({
    required this.userId,
    required this.coachingSummary,
    required this.recommendations,
    required this.priorityWeaknesses,
    required this.weeklyFocusAreas,
    required this.monthlyFocusAreas,
    required this.generatedAt,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'coachingSummary': coachingSummary,
        'recommendations': recommendations.map((r) => r.toJson()).toList(),
        'priorityWeaknesses': priorityWeaknesses.map((w) => w.toJson()).toList(),
        'weeklyFocusAreas': weeklyFocusAreas.map((w) => w.toJson()).toList(),
        'monthlyFocusAreas': monthlyFocusAreas.map((m) => m.toJson()).toList(),
        'generatedAt': generatedAt.toIso8601String(),
      };

  factory CompleteCoachingProfile.fromJson(Map<String, dynamic> json) =>
      CompleteCoachingProfile(
        userId: json['userId'] as String,
        coachingSummary: json['coachingSummary'] as String,
        recommendations: (json['recommendations'] as List)
            .map((r) => CoachingRecommendation.fromJson(r as Map<String, dynamic>))
            .toList(),
        priorityWeaknesses: (json['priorityWeaknesses'] as List)
            .map((w) => FocusArea.fromJson(w as Map<String, dynamic>))
            .toList(),
        weeklyFocusAreas: (json['weeklyFocusAreas'] as List)
            .map((w) => FocusArea.fromJson(w as Map<String, dynamic>))
            .toList(),
        monthlyFocusAreas: (json['monthlyFocusAreas'] as List)
            .map((m) => FocusArea.fromJson(m as Map<String, dynamic>))
            .toList(),
        generatedAt: DateTime.parse(json['generatedAt'] as String),
      );
}
