import 'package:cloud_firestore/cloud_firestore.dart';
import '../../ecosystem/intelligence/models/player_dna_model.dart';
import '../models/coaching_models.dart';

class CoachEngineService {
  final FirebaseFirestore _firestore;

  CoachEngineService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static CompleteCoachingProfile generateCoachingProfile({
    required PlayerDnaModel dna,
    required List<Map<String, dynamic>> weaknessLogs,
    required List<Map<String, dynamic>> puzzleHistory,
    required List<Map<String, dynamic>> performanceSnapshots,
  }) {
    final List<CoachingRecommendation> recs = [];
    final List<FocusArea> weaknesses = [];
    final List<FocusArea> weeklyFocus = [];
    final List<FocusArea> monthlyFocus = [];

    final tacticalScore = dna.weaknessScores.tacticalOversights;
    if (tacticalScore > 15.0) {
      recs.add(const CoachingRecommendation(
        recommendationId: 'rec_tactics_01',
        title: 'Sharpen Tactical Vision',
        description: 'Your tactical oversight rate is higher than average.',
        category: 'tactics',
        priority: PriorityLevel.critical,
        recommendedActionItems: [
          'Solve 15 fork and pin tactical puzzles daily',
          'Use candidate move calculation in middlegames',
        ],
      ));

      weaknesses.add(FocusArea(
        areaId: 'weak_tactics',
        title: 'Tactical Calculation Overlooks',
        category: 'tactics',
        targetScore: 5.0,
        currentScore: tacticalScore,
        keyObjective: 'Reduce blunder rate below 1.5% in rapid games.',
      ));
    }

    final summary = 'Coaching Analysis: Style is ${dna.primaryStyle.name.toUpperCase()}. '
        'Overall accuracy is ${dna.accuracyMetrics.overall.toStringAsFixed(1)}%.';

    return CompleteCoachingProfile(
      userId: dna.userId,
      coachingSummary: summary,
      recommendations: recs,
      priorityWeaknesses: weaknesses,
      weeklyFocusAreas: weeklyFocus,
      monthlyFocusAreas: monthlyFocus,
      generatedAt: DateTime.now(),
    );
  }

  Future<void> saveCoachingProfile(CompleteCoachingProfile profile) async {
    final docRef = _firestore.collection('coaching_profiles').doc(profile.userId);
    await docRef.set(profile.toJson(), SetOptions(merge: true));
  }

  Future<CompleteCoachingProfile?> fetchCoachingProfile(String userId) async {
    final docRef = _firestore.collection('coaching_profiles').doc(userId);
    final snapshot = await docRef.get();
    if (snapshot.exists && snapshot.data() != null) {
      return CompleteCoachingProfile.fromJson(snapshot.data()!);
    }
    return null;
  }
}
