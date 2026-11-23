class ImPathCalculator {
  static Map<String, dynamic> evaluateImProgress({
    required int currentFideRating,
    required int normsCompleted,
  }) {
    const targetRating = 2400;
    return {
      'targetTitle': 'International Master (IM)',
      'targetRating': targetRating,
      'normsCompleted': normsCompleted,
      'normsRequired': 3,
      'ratingProgressPercentage': (currentFideRating / targetRating).clamp(0.0, 1.0) * 100.0,
      'keyActionable': 'Compete in FIDE-rated round-robin tournaments aiming for 2450+ performance.',
    };
  }
}
