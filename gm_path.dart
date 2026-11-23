class GmPathCalculator {
  static Map<String, dynamic> evaluateGmProgress({
    required int currentFideRating,
    required int gmNormsCompleted,
  }) {
    const targetRating = 2500;
    return {
      'targetTitle': 'Grandmaster (GM)',
      'targetRating': targetRating,
      'normsCompleted': gmNormsCompleted,
      'normsRequired': 3,
      'ratingProgressPercentage': (currentFideRating / targetRating).clamp(0.0, 1.0) * 100.0,
      'keyActionable': 'Compete against 2600+ opposition with prepared novelties.',
    };
  }
}
