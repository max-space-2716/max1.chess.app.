class NmPathCalculator {
  static Map<String, dynamic> evaluateNmProgress({
    required int currentRating,
    required double tacticalAccuracy,
    required int classicalGamesPlayed,
  }) {
    const targetRating = 2200;
    final ratingProgress = (currentRating / targetRating).clamp(0.0, 1.0) * 100.0;
    final readiness = (ratingProgress * 0.6) +
        (tacticalAccuracy * 0.3) +
        ((classicalGamesPlayed / 50.0).clamp(0.0, 1.0) * 10.0);

    return {
      'targetTitle': 'National Master (NM)',
      'targetRating': targetRating,
      'ratingDelta': (targetRating - currentRating).clamp(0, 2200),
      'ratingProgressPercentage': ratingProgress,
      'overallReadinessScore': readiness.clamp(0.0, 100.0),
      'keyActionable': currentRating < 2000
          ? 'Focus on tactical calculation and solidifying 1 primary repertoire.'
          : 'Increase classical slow game frequency and endgames precision.',
    };
  }
}
