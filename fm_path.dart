class FmPathCalculator {
  static Map<String, dynamic> evaluateFmProgress({
    required int currentFideRating,
    required double openingRepertoireDepth,
  }) {
    const targetRating = 2300;
    return {
      'targetTitle': 'FIDE Master (FM)',
      'targetRating': targetRating,
      'progressPercentage': (currentFideRating / targetRating).clamp(0.0, 1.0) * 100.0,
      'keyActionable': 'Deepen opening preparation with engine analysis and refine positional evaluation.',
    };
  }
}
