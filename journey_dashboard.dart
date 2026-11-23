import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/journey_providers.dart';

class JourneyDashboard extends ConsumerWidget {
  final String userId;

  const JourneyDashboard({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeyAsync = ref.watch(journeyProvider(userId));
    final forecastAsync = ref.watch(forecastProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('GM Journey Dashboard'),
      ),
      body: journeyAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('No Journey Profile found.'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderCard(profile),
                const SizedBox(height: 16),
                _buildForecastSection(forecastAsync),
                const SizedBox(height: 16),
                _buildTitlePathProgress(profile),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: \$err')),
      ),
    );
  }

  Widget _buildHeaderCard(profile) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Current Rating: \${profile.currentFideRating}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Mastery Score: \${profile.overallMasteryScore.toStringAsFixed(1)}%'),
            Text('Velocity: \${profile.improvementVelocity.toStringAsFixed(1)} pts/mo'),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastSection(AsyncValue forecastAsync) {
    return forecastAsync.when(
      data: (forecast) {
        if (forecast == null) return const SizedBox();
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Projections', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(),
                Text('30-Day Projected: \${forecast.forecast30Days}'),
                Text('90-Day Projected: \${forecast.forecast90Days}'),
                Text('365-Day Projected: \${forecast.forecast365Days}'),
              ],
            ),
          ),
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (_, __) => const Text('Failed to load forecast.'),
    );
  }

  Widget _buildTitlePathProgress(profile) {
    return Card(
      child: ListTile(
        title: Text('Path to \${profile.currentTitlePath.name.toUpperCase()}'),
        subtitle: const Text('Targeting next rating baseline and performance threshold.'),
        trailing: const Icon(Icons.workspace_premium),
      ),
    );
  }
}
