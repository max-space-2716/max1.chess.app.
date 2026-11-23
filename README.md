# MAX.CHESS.APP — Programs A–D (GitHub Repository Bundle)

Complete architectural codebase for **MAX.CHESS.APP** across **Program A** (Foundation & Core Infrastructure), **Program B** (Player DNA & Intelligence), **Program C** (AI Coaching & Training Plans), and **Program D** (GM Journey, Title Paths & Rating Forecasts). Total files in this bundle: **18**.

## Repository Layout
- `lib/features/ecosystem/intelligence/models/player_dna_model.dart` — Player DNA domain models, accuracy metrics, weakness profiles, and risk/growth models.
- `lib/features/coaching/models/coaching_models.dart` — Coaching recommendations, focus areas, and complete coaching profile models.
- `lib/features/coaching/models/training_plan_models.dart` — Personalized training schedules, daily tasks, and task categories.
- `lib/features/journey/models/journey_profile_model.dart` — GM Journey profile and title path definitions.
- `lib/features/journey/models/milestone_model.dart` — Rating and achievement milestones.
- `lib/features/journey/models/rating_forecast_model.dart` — 30/90/365-day rating forecast model.
- `lib/features/coaching/services/coach_engine.dart` — Adaptive AI coach profile generator and Firestore persistence service.
- `lib/features/journey/services/rating_milestone_engine.dart` — Rating milestone generator and batch updater.
- `lib/features/journey/services/nm_path.dart` — National Master (NM) path progress evaluator.
- `lib/features/journey/services/fm_path.dart` — FIDE Master (FM) path progress evaluator.
- `lib/features/journey/services/im_path.dart` — International Master (IM) path and norm progress evaluator.
- `lib/features/journey/services/gm_path.dart` — Grandmaster (GM) path and norm progress evaluator.
- `lib/features/journey/services/forecast_engine.dart` — Velocity- and consistency-adjusted rating projection engine.
- `lib/features/journey/services/progression_engine.dart` — Composite mastery score calculator.
- `lib/features/journey/providers/journey_providers.dart` — Riverpod AsyncNotifier providers for journey profiles, milestones, and forecasts.
- `lib/features/journey/ui/journey_dashboard.dart` — GM Journey Dashboard Flutter UI screen.
- `functions/src/journey_functions.ts` — Firebase Cloud Functions v2 callables for forecast calculation and mastery score updates.
