import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/journey_profile_model.dart';
import '../models/milestone_model.dart';
import '../models/rating_forecast_model.dart';

class JourneyNotifier extends FamilyAsyncNotifier<JourneyProfileModel?, String> {
  @override
  FutureOr<JourneyProfileModel?> build(String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection('journey_profiles')
        .doc(userId)
        .get();

    if (doc.exists && doc.data() != null) {
      return JourneyProfileModel.fromJson(doc.data()!);
    }
    return null;
  }
}

final journeyProvider = AsyncNotifierProviderFamily<JourneyNotifier, JourneyProfileModel?, String>(
  JourneyNotifier.new,
);

class MilestoneNotifier extends FamilyAsyncNotifier<List<MilestoneModel>, String> {
  @override
  FutureOr<List<MilestoneModel>> build(String userId) async {
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('rating_milestones')
        .get();

    return snap.docs.map((doc) => MilestoneModel.fromJson(doc.data())).toList();
  }
}

final milestoneProvider = AsyncNotifierProviderFamily<MilestoneNotifier, List<MilestoneModel>, String>(
  MilestoneNotifier.new,
);

class ForecastNotifier extends FamilyAsyncNotifier<RatingForecastModel?, String> {
  @override
  FutureOr<RatingForecastModel?> build(String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('rating_forecasts')
        .doc('latest_forecast')
        .get();

    if (doc.exists && doc.data() != null) {
      return RatingForecastModel.fromJson(doc.data()!);
    }
    return null;
  }
}

final forecastProvider = AsyncNotifierProviderFamily<ForecastNotifier, RatingForecastModel?, String>(
  ForecastNotifier.new,
);
