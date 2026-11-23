class ProgressionEngineService {
  static double calculateMasteryScore({
    required double tacticalAccuracy,
    required double positionalScore,
    required double endgameScore,
    required double openingScore,
  }) {
    return ((tacticalAccuracy * 0.35) +
            (positionalScore * 0.25) +
            (endgameScore * 0.25) +
            (openingScore * 0.15))
        .clamp(0.0, 100.0);
  }
}
