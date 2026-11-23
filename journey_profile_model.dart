import 'package:cloud_firestore/cloud_firestore.dart';

enum TitlePathType { classPlayer, candidateMaster, nationalMaster, fideMaster, internationalMaster, grandmaster }

class JourneyProfileModel {
  final String userId;
  final int currentFideRating;
  final int currentNationalRating;
  final int peakRating;
  final TitlePathType currentTitlePath;
  final double overallMasteryScore;
  final double improvementVelocity;
  final DateTime journeyStartedAt;
  final DateTime updatedAt;

  const JourneyProfileModel({
    required this.userId,
    required this.currentFideRating,
    required this.currentNationalRating,
    required this.peakRating,
    required this.currentTitlePath,
    required this.overallMasteryScore,
    required this.improvementVelocity,
    required this.journeyStartedAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'currentFideRating': currentFideRating,
        'currentNationalRating': currentNationalRating,
        'peakRating': peakRating,
        'currentTitlePath': currentTitlePath.name,
        'overallMasteryScore': overallMasteryScore,
        'improvementVelocity': improvementVelocity,
        'journeyStartedAt': journeyStartedAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory JourneyProfileModel.fromJson(Map<String, dynamic> json) => JourneyProfileModel(
        userId: json['userId'] as String,
        currentFideRating: json['currentFideRating'] as int? ?? 1200,
        currentNationalRating: json['currentNationalRating'] as int? ?? 1200,
        peakRating: json['peakRating'] as int? ?? 1200,
        currentTitlePath: TitlePathType.values.firstWhere(
          (e) => e.name == json['currentTitlePath'],
          orElse: () => TitlePathType.classPlayer,
        ),
        overallMasteryScore: (json['overallMasteryScore'] as num? ?? 0.0).toDouble(),
        improvementVelocity: (json['improvementVelocity'] as num? ?? 0.0).toDouble(),
        journeyStartedAt: json['journeyStartedAt'] != null
            ? DateTime.parse(json['journeyStartedAt'] as String)
            : DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : DateTime.now(),
      );
}
