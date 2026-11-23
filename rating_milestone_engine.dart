import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/milestone_model.dart';

class RatingMilestoneEngine {
  final FirebaseFirestore _firestore;

  RatingMilestoneEngine({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static List<MilestoneModel> generateStandardMilestones(String userId, int currentRating) {
    return [
      MilestoneModel(
        milestoneId: 'ms_1600',
        userId: userId,
        title: 'Class A Player',
        description: 'Cross 1600 official rating barrier.',
        category: MilestoneCategory.rating,
        targetValue: 1600,
        currentValue: currentRating,
        isUnlocked: currentRating >= 1600,
        unlockedAt: currentRating >= 1600 ? DateTime.now() : null,
      ),
      MilestoneModel(
        milestoneId: 'ms_2000',
        userId: userId,
        title: 'Expert Candidate',
        description: 'Cross 2000 official rating barrier.',
        category: MilestoneCategory.rating,
        targetValue: 2000,
        currentValue: currentRating,
        isUnlocked: currentRating >= 2000,
        unlockedAt: currentRating >= 2000 ? DateTime.now() : null,
      ),
      MilestoneModel(
        milestoneId: 'ms_2200',
        userId: userId,
        title: 'National Master Target',
        description: 'Cross 2200 USCF/National rating.',
        category: MilestoneCategory.rating,
        targetValue: 2200,
        currentValue: currentRating,
        isUnlocked: currentRating >= 2200,
        unlockedAt: currentRating >= 2200 ? DateTime.now() : null,
      ),
      MilestoneModel(
        milestoneId: 'ms_2300',
        userId: userId,
        title: 'FIDE Master Target',
        description: 'Reach 2300 FIDE Rating standard.',
        category: MilestoneCategory.rating,
        targetValue: 2300,
        currentValue: currentRating,
        isUnlocked: currentRating >= 2300,
        unlockedAt: currentRating >= 2300 ? DateTime.now() : null,
      ),
    ];
  }

  Future<void> updateMilestones(String userId, List<MilestoneModel> milestones) async {
    final batch = _firestore.batch();
    for (var ms in milestones) {
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('rating_milestones')
          .doc(ms.milestoneId);
      batch.set(docRef, ms.toJson(), SetOptions(merge: true));
    }
    await batch.commit();
  }
}
