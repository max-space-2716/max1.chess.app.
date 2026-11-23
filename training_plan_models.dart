enum TrainingTaskCategory {
  puzzleWork,
  openingWork,
  endgameStudy,
  reviewSession,
  tacticalDrill,
  gameAnalysis,
}

class TrainingTask {
  final String taskId;
  final String title;
  final String description;
  final TrainingTaskCategory category;
  final int targetMinutes;
  final bool isCompleted;
  final Map<String, dynamic> metadata;

  const TrainingTask({
    required this.taskId,
    required this.title,
    required this.description,
    required this.category,
    required this.targetMinutes,
    required this.isCompleted,
    this.metadata = const {},
  });

  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'title': title,
        'description': description,
        'category': category.name,
        'targetMinutes': targetMinutes,
        'isCompleted': isCompleted,
        'metadata': metadata,
      };

  factory TrainingTask.fromJson(Map<String, dynamic> json) => TrainingTask(
        taskId: json['taskId'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: TrainingTaskCategory.values.firstWhere(
          (e) => e.name == json['category'],
          orElse: () => TrainingTaskCategory.puzzleWork,
        ),
        targetMinutes: json['targetMinutes'] as int,
        isCompleted: json['isCompleted'] as bool? ?? false,
        metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
      );
}

class DailySchedule {
  final int dayNumber;
  final String dateKey;
  final List<TrainingTask> tasks;
  final int totalTargetMinutes;
  final bool isDayCompleted;

  const DailySchedule({
    required this.dayNumber,
    required this.dateKey,
    required this.tasks,
    required this.totalTargetMinutes,
    required this.isDayCompleted,
  });

  Map<String, dynamic> toJson() => {
        'dayNumber': dayNumber,
        'dateKey': dateKey,
        'tasks': tasks.map((t) => t.toJson()).toList(),
        'totalTargetMinutes': totalTargetMinutes,
        'isDayCompleted': isDayCompleted,
      };

  factory DailySchedule.fromJson(Map<String, dynamic> json) => DailySchedule(
        dayNumber: json['dayNumber'] as int,
        dateKey: json['dateKey'] as String,
        tasks: (json['tasks'] as List)
            .map((t) => TrainingTask.fromJson(t as Map<String, dynamic>))
            .toList(),
        totalTargetMinutes: json['totalTargetMinutes'] as int,
        isDayCompleted: json['isDayCompleted'] as bool? ?? false,
      );
}

class PersonalizedTrainingPlan {
  final String planId;
  final String userId;
  final int durationDays;
  final String focusPrimaryCategory;
  final List<DailySchedule> schedule;
  final DateTime createdAt;
  final DateTime expiresAt;

  const PersonalizedTrainingPlan({
    required this.planId,
    required this.userId,
    required this.durationDays,
    required this.focusPrimaryCategory,
    required this.schedule,
    required this.createdAt,
    required this.expiresAt,
  });

  Map<String, dynamic> toJson() => {
        'planId': planId,
        'userId': userId,
        'durationDays': durationDays,
        'focusPrimaryCategory': focusPrimaryCategory,
        'schedule': schedule.map((s) => s.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
        'expiresAt': expiresAt.toIso8601String(),
      };

  factory PersonalizedTrainingPlan.fromJson(Map<String, dynamic> json) =>
      PersonalizedTrainingPlan(
        planId: json['planId'] as String,
        userId: json['userId'] as String,
        durationDays: json['durationDays'] as int,
        focusPrimaryCategory: json['focusPrimaryCategory'] as String,
        schedule: (json['schedule'] as List)
            .map((s) => DailySchedule.fromJson(s as Map<String, dynamic>))
            .toList(),
        createdAt: DateTime.parse(json['createdAt'] as String),
        expiresAt: DateTime.parse(json['expiresAt'] as String),
      );
}
