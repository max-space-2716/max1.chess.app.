import 'package:cloud_firestore/cloud_firestore.dart';

enum PlayerStyle { tactical, positional, universal, aggressive, solid }
enum RiskTolerance { low, moderate, aggressive }

class OpeningStyleProfile {
  final List<String> favoriteOpenings;
  final double theoryKnowledgeScore;
  final double sharpnessIndex;
  final double whiteWinRate;
  final double blackWinRate;

  const OpeningStyleProfile({
    required this.favoriteOpenings,
    required this.theoryKnowledgeScore,
    required this.sharpnessIndex,
    required this.whiteWinRate,
    required this.blackWinRate,
  });

  Map<String, dynamic> toJson() => {
        'favoriteOpenings': favoriteOpenings,
        'theoryKnowledgeScore': theoryKnowledgeScore,
        'sharpnessIndex': sharpnessIndex,
        'whiteWinRate': whiteWinRate,
        'blackWinRate': blackWinRate,
      };

  factory OpeningStyleProfile.fromJson(Map<String, dynamic> json) => OpeningStyleProfile(
        favoriteOpenings: List<String>.from(json['favoriteOpenings'] ?? []),
        theoryKnowledgeScore: (json['theoryKnowledgeScore'] as num? ?? 0.0).toDouble(),
        sharpnessIndex: (json['sharpnessIndex'] as num? ?? 0.0).toDouble(),
        whiteWinRate: (json['whiteWinRate'] as num? ?? 0.0).toDouble(),
        blackWinRate: (json['blackWinRate'] as num? ?? 0.0).toDouble(),
      );
}

class TacticalStrengthProfile {
  final double forkScore;
  final double pinScore;
  final double skewerScore;
  final double discoveredAttackScore;
  final double calculationDepthScore;
  final double tacticalEfficiency;

  const TacticalStrengthProfile({
    required this.forkScore,
    required this.pinScore,
    required this.skewerScore,
    required this.discoveredAttackScore,
    required this.calculationDepthScore,
    required this.tacticalEfficiency,
  });

  Map<String, dynamic> toJson() => {
        'forkScore': forkScore,
        'pinScore': pinScore,
        'skewerScore': skewerScore,
        'discoveredAttackScore': discoveredAttackScore,
        'calculationDepthScore': calculationDepthScore,
        'tacticalEfficiency': tacticalEfficiency,
      };

  factory TacticalStrengthProfile.fromJson(Map<String, dynamic> json) => TacticalStrengthProfile(
        forkScore: (json['forkScore'] as num? ?? 0.0).toDouble(),
        pinScore: (json['pinScore'] as num? ?? 0.0).toDouble(),
        skewerScore: (json['skewerScore'] as num? ?? 0.0).toDouble(),
        discoveredAttackScore: (json['discoveredAttackScore'] as num? ?? 0.0).toDouble(),
        calculationDepthScore: (json['calculationDepthScore'] as num? ?? 0.0).toDouble(),
        tacticalEfficiency: (json['tacticalEfficiency'] as num? ?? 0.0).toDouble(),
      );
}

class PositionalStrengthProfile {
  final double pawnStructureScore;
  final double pieceCoordinationScore;
  final double prophylaxisScore;
  final double kingSafetyScore;
  final double spaceAdvantageConversion;

  const PositionalStrengthProfile({
    required this.pawnStructureScore,
    required this.pieceCoordinationScore,
    required this.prophylaxisScore,
    required this.kingSafetyScore,
    required this.spaceAdvantageConversion,
  });

  Map<String, dynamic> toJson() => {
        'pawnStructureScore': pawnStructureScore,
        'pieceCoordinationScore': pieceCoordinationScore,
        'prophylaxisScore': prophylaxisScore,
        'kingSafetyScore': kingSafetyScore,
        'spaceAdvantageConversion': spaceAdvantageConversion,
      };

  factory PositionalStrengthProfile.fromJson(Map<String, dynamic> json) => PositionalStrengthProfile(
        pawnStructureScore: (json['pawnStructureScore'] as num? ?? 0.0).toDouble(),
        pieceCoordinationScore: (json['pieceCoordinationScore'] as num? ?? 0.0).toDouble(),
        prophylaxisScore: (json['prophylaxisScore'] as num? ?? 0.0).toDouble(),
        kingSafetyScore: (json['kingSafetyScore'] as num? ?? 0.0).toDouble(),
        spaceAdvantageConversion: (json['spaceAdvantageConversion'] as num? ?? 0.0).toDouble(),
      );
}

class EndgameProfile {
  final double pawnEndgameScore;
  final double rookEndgameScore;
  final double minorPieceEndgameScore;
  final double technicalConversionRate;

  const EndgameProfile({
    required this.pawnEndgameScore,
    required this.rookEndgameScore,
    required this.minorPieceEndgameScore,
    required this.technicalConversionRate,
  });

  Map<String, dynamic> toJson() => {
        'pawnEndgameScore': pawnEndgameScore,
        'rookEndgameScore': rookEndgameScore,
        'minorPieceEndgameScore': minorPieceEndgameScore,
        'technicalConversionRate': technicalConversionRate,
      };

  factory EndgameProfile.fromJson(Map<String, dynamic> json) => EndgameProfile(
        pawnEndgameScore: (json['pawnEndgameScore'] as num? ?? 0.0).toDouble(),
        rookEndgameScore: (json['rookEndgameScore'] as num? ?? 0.0).toDouble(),
        minorPieceEndgameScore: (json['minorPieceEndgameScore'] as num? ?? 0.0).toDouble(),
        technicalConversionRate: (json['technicalConversionRate'] as num? ?? 0.0).toDouble(),
      );
}

class TimeManagementProfile {
  final double averageMoveTimeSeconds;
  final double timeTroubleFrequency;
  final double blitzEfficiency;
  final double rapidEfficiency;

  const TimeManagementProfile({
    required this.averageMoveTimeSeconds,
    required this.timeTroubleFrequency,
    required this.blitzEfficiency,
    required this.rapidEfficiency,
  });

  Map<String, dynamic> toJson() => {
        'averageMoveTimeSeconds': averageMoveTimeSeconds,
        'timeTroubleFrequency': timeTroubleFrequency,
        'blitzEfficiency': blitzEfficiency,
        'rapidEfficiency': rapidEfficiency,
      };

  factory TimeManagementProfile.fromJson(Map<String, dynamic> json) => TimeManagementProfile(
        averageMoveTimeSeconds: (json['averageMoveTimeSeconds'] as num? ?? 0.0).toDouble(),
        timeTroubleFrequency: (json['timeTroubleFrequency'] as num? ?? 0.0).toDouble(),
        blitzEfficiency: (json['blitzEfficiency'] as num? ?? 0.0).toDouble(),
        rapidEfficiency: (json['rapidEfficiency'] as num? ?? 0.0).toDouble(),
      );
}

class AccuracyMetrics {
  final double opening;
  final double middlegame;
  final double endgame;
  final double overall;
  final double blunderRate;
  final double mistakeRate;

  const AccuracyMetrics({
    required this.opening,
    required this.middlegame,
    required this.endgame,
    required this.overall,
    required this.blunderRate,
    required this.mistakeRate,
  });

  Map<String, dynamic> toJson() => {
        'opening': opening,
        'middlegame': middlegame,
        'endgame': endgame,
        'overall': overall,
        'blunderRate': blunderRate,
        'mistakeRate': mistakeRate,
      };

  factory AccuracyMetrics.fromJson(Map<String, dynamic> json) => AccuracyMetrics(
        opening: (json['opening'] as num? ?? 0.0).toDouble(),
        middlegame: (json['middlegame'] as num? ?? 0.0).toDouble(),
        endgame: (json['endgame'] as num? ?? 0.0).toDouble(),
        overall: (json['overall'] as num? ?? 0.0).toDouble(),
        blunderRate: (json['blunderRate'] as num? ?? 0.0).toDouble(),
        mistakeRate: (json['mistakeRate'] as num? ?? 0.0).toDouble(),
      );
}

class WeaknessScores {
  final double tacticalOversights;
  final double timeTrouble;
  final double endgameTechnique;
  final double openingPreparation;
  final double defensiveResilience;

  const WeaknessScores({
    required this.tacticalOversights,
    required this.timeTrouble,
    required this.endgameTechnique,
    required this.openingPreparation,
    required this.defensiveResilience,
  });

  Map<String, dynamic> toJson() => {
        'tacticalOversights': tacticalOversights,
        'timeTrouble': timeTrouble,
        'endgameTechnique': endgameTechnique,
        'openingPreparation': openingPreparation,
        'defensiveResilience': defensiveResilience,
      };

  factory WeaknessScores.fromJson(Map<String, dynamic> json) => WeaknessScores(
        tacticalOversights: (json['tacticalOversights'] as num? ?? 0.0).toDouble(),
        timeTrouble: (json['timeTrouble'] as num? ?? 0.0).toDouble(),
        endgameTechnique: (json['endgameTechnique'] as num? ?? 0.0).toDouble(),
        openingPreparation: (json['openingPreparation'] as num? ?? 0.0).toDouble(),
        defensiveResilience: (json['defensiveResilience'] as num? ?? 0.0).toDouble(),
      );
}

class RiskProfile {
  final double aggressionScore;
  final RiskTolerance riskTolerance;
  final double unsoundSacrificeRate;

  const RiskProfile({
    required this.aggressionScore,
    required this.riskTolerance,
    required this.unsoundSacrificeRate,
  });

  Map<String, dynamic> toJson() => {
        'aggressionScore': aggressionScore,
        'riskTolerance': riskTolerance.name,
        'unsoundSacrificeRate': unsoundSacrificeRate,
      };

  factory RiskProfile.fromJson(Map<String, dynamic> json) => RiskProfile(
        aggressionScore: (json['aggressionScore'] as num? ?? 0.0).toDouble(),
        riskTolerance: RiskTolerance.values.firstWhere(
          (e) => e.name == json['riskTolerance'],
          orElse: () => RiskTolerance.moderate,
        ),
        unsoundSacrificeRate: (json['unsoundSacrificeRate'] as num? ?? 0.0).toDouble(),
      );
}

class GrowthMetrics {
  final int puzzleRating;
  final int tacticalTrainingStreak;
  final double consistencyScore;

  const GrowthMetrics({
    required this.puzzleRating,
    required this.tacticalTrainingStreak,
    required this.consistencyScore,
  });

  Map<String, dynamic> toJson() => {
        'puzzleRating': puzzleRating,
        'tacticalTrainingStreak': tacticalTrainingStreak,
        'consistencyScore': consistencyScore,
      };

  factory GrowthMetrics.fromJson(Map<String, dynamic> json) => GrowthMetrics(
        puzzleRating: json['puzzleRating'] as int? ?? 1200,
        tacticalTrainingStreak: json['tacticalTrainingStreak'] as int? ?? 0,
        consistencyScore: (json['consistencyScore'] as num? ?? 0.0).toDouble(),
      );
}

class ImprovementVelocity {
  final double weeklyRatingDelta;
  final double accuracyGrowthRate;
  final double bottleneckResolutionScore;

  const ImprovementVelocity({
    required this.weeklyRatingDelta,
    required this.accuracyGrowthRate,
    required this.bottleneckResolutionScore,
  });

  Map<String, dynamic> toJson() => {
        'weeklyRatingDelta': weeklyRatingDelta,
        'accuracyGrowthRate': accuracyGrowthRate,
        'bottleneckResolutionScore': bottleneckResolutionScore,
      };

  factory ImprovementVelocity.fromJson(Map<String, dynamic> json) => ImprovementVelocity(
        weeklyRatingDelta: (json['weeklyRatingDelta'] as num? ?? 0.0).toDouble(),
        accuracyGrowthRate: (json['accuracyGrowthRate'] as num? ?? 0.0).toDouble(),
        bottleneckResolutionScore: (json['bottleneckResolutionScore'] as num? ?? 0.0).toDouble(),
      );
}

class PlayerDnaModel {
  final String userId;
  final PlayerStyle primaryStyle;
  final OpeningStyleProfile openingStyle;
  final TacticalStrengthProfile tacticalStrength;
  final PositionalStrengthProfile positionalStrength;
  final EndgameProfile endgameProfile;
  final TimeManagementProfile timeManagementProfile;
  final AccuracyMetrics accuracyMetrics;
  final WeaknessScores weaknessScores;
  final RiskProfile riskProfile;
  final GrowthMetrics growthMetrics;
  final ImprovementVelocity improvementVelocity;
  final DateTime updatedAt;

  const PlayerDnaModel({
    required this.userId,
    required this.primaryStyle,
    required this.openingStyle,
    required this.tacticalStrength,
    required this.positionalStrength,
    required this.endgameProfile,
    required this.timeManagementProfile,
    required this.accuracyMetrics,
    required this.weaknessScores,
    required this.riskProfile,
    required this.growthMetrics,
    required this.improvementVelocity,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'primaryStyle': primaryStyle.name,
        'openingStyle': openingStyle.toJson(),
        'tacticalStrength': tacticalStrength.toJson(),
        'positionalStrength': positionalStrength.toJson(),
        'endgameProfile': endgameProfile.toJson(),
        'timeManagementProfile': timeManagementProfile.toJson(),
        'accuracyMetrics': accuracyMetrics.toJson(),
        'weaknessScores': weaknessScores.toJson(),
        'riskProfile': riskProfile.toJson(),
        'growthMetrics': growthMetrics.toJson(),
        'improvementVelocity': improvementVelocity.toJson(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory PlayerDnaModel.fromJson(Map<String, dynamic> json) => PlayerDnaModel(
        userId: json['userId'] as String,
        primaryStyle: PlayerStyle.values.firstWhere(
          (e) => e.name == json['primaryStyle'],
          orElse: () => PlayerStyle.universal,
        ),
        openingStyle: OpeningStyleProfile.fromJson(json['openingStyle'] as Map<String, dynamic>),
        tacticalStrength: TacticalStrengthProfile.fromJson(json['tacticalStrength'] as Map<String, dynamic>),
        positionalStrength: PositionalStrengthProfile.fromJson(json['positionalStrength'] as Map<String, dynamic>),
        endgameProfile: EndgameProfile.fromJson(json['endgameProfile'] as Map<String, dynamic>),
        timeManagementProfile: TimeManagementProfile.fromJson(json['timeManagementProfile'] as Map<String, dynamic>),
        accuracyMetrics: AccuracyMetrics.fromJson(json['accuracyMetrics'] as Map<String, dynamic>),
        weaknessScores: WeaknessScores.fromJson(json['weaknessScores'] as Map<String, dynamic>),
        riskProfile: RiskProfile.fromJson(json['riskProfile'] as Map<String, dynamic>),
        growthMetrics: GrowthMetrics.fromJson(json['growthMetrics'] as Map<String, dynamic>),
        improvementVelocity: ImprovementVelocity.fromJson(json['improvementVelocity'] as Map<String, dynamic>),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
}
