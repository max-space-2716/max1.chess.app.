class RatingForecastModel {
  final String forecastId;
  final String userId;
  final int currentRating;
  final int forecast30Days;
  final int forecast90Days;
  final int forecast365Days;
  final double confidenceInterval;
  final DateTime calculatedAt;

  const RatingForecastModel({
    required this.forecastId,
    required this.userId,
    required this.currentRating,
    required this.forecast30Days,
    required this.forecast90Days,
    required this.forecast365Days,
    required this.confidenceInterval,
    required this.calculatedAt,
  });

  Map<String, dynamic> toJson() => {
        'forecastId': forecastId,
        'userId': userId,
        'currentRating': currentRating,
        'forecast30Days': forecast30Days,
        'forecast90Days': forecast90Days,
        'forecast365Days': forecast365Days,
        'confidenceInterval': confidenceInterval,
        'calculatedAt': calculatedAt.toIso8601String(),
      };

  factory RatingForecastModel.fromJson(Map<String, dynamic> json) => RatingForecastModel(
        forecastId: json['forecastId'] as String,
        userId: json['userId'] as String,
        currentRating: json['currentRating'] as int,
        forecast30Days: json['forecast30Days'] as int,
        forecast90Days: json['forecast90Days'] as int,
        forecast365Days: json['forecast365Days'] as int,
        confidenceInterval: (json['confidenceInterval'] as num).toDouble(),
        calculatedAt: DateTime.parse(json['calculatedAt'] as String),
      );
}
