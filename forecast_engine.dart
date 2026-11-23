import '../models/rating_forecast_model.dart';

class JourneyForecastEngine {
  static RatingForecastModel calculateForecast({
    required String userId,
    required int currentRating,
    required double monthlyVelocity,
    required double consistencyScore,
  }) {
    final effectiveVelocity = monthlyVelocity * consistencyScore.clamp(0.1, 1.0);
    return RatingForecastModel(
      forecastId: 'forecast_\${userId}_\${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      currentRating: currentRating,
      forecast30Days: currentRating + (effectiveVelocity * 1.0).round(),
      forecast90Days: currentRating + (effectiveVelocity * 3.0 * 0.90).round(),
      forecast365Days: currentRating + (effectiveVelocity * 12.0 * 0.70).round(),
      confidenceInterval: consistencyScore.clamp(0.5, 0.95),
      calculatedAt: DateTime.now(),
    );
  }
}
