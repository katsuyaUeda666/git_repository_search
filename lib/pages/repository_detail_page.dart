import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_repository_search/model/repository.dart';
import 'package:git_repository_search/controller/repository_detail_controller.dart';

class RepositoryDetailPage extends ConsumerWidget {
  final String owner;
  final String repo;

  const RepositoryDetailPage({
    Key? key,
    required this.owner,
    required this.repo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryAsync = ref.watch(
      repositoryDetailControllerProvider((owner, repo)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('$owner / $repo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(repositoryDetailControllerProvider),
          ),
        ],
      ),
      body: repositoryAsync.when(
        data: (repository) => _buildDetailContent(context, repository),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _buildErrorWidget(context, error, ref),
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context, Repository repository) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(context, repository),
          const SizedBox(height: 24),
          _buildStatsGrid(repository),
          const SizedBox(height: 24),
          _buildAdditionalInfo(context, repository),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Repository repository) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 48,
          backgroundImage: NetworkImage(repository.owner.avatarUrl ?? ''),
          onBackgroundImageError: (_, __) => const Icon(Icons.error),
          child: repository.owner.avatarUrl == null
              ? const Icon(Icons.person, size: 48)
              : null,
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repository.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              if (repository.owner.login != null)
                Text(
                  'by ${repository.owner.login}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(Repository repository) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            childAspectRatio: constraints.maxWidth > 600 ? 2 : 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildStatItem(
                icon: Icons.star_rounded,
                color: Colors.amber,
                label: 'Stars',
                value: repository.stargazersCount ?? 0,
                iconSize: 24.0,
              ),
              _buildStatItem(
                icon: Icons.remove_red_eye_rounded,
                color: Colors.blue,
                label: 'Watchers',
                value: repository.watchersCount ?? 0,
                iconSize: 24.0,
              ),
              _buildStatItem(
                icon: Icons.call_split_rounded,
                color: Colors.green,
                label: 'Forks',
                value: repository.forksCount ?? 0,
                iconSize: 24.0,
              ),
              _buildStatItem(
                icon: Icons.error_outline_rounded,
                color: Colors.red,
                label: 'Issues',
                value: repository.openIssuesCount ?? 0,
                iconSize: 24.0,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color color,
    required String label,
    required int value,
    required double iconSize,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: color, size: iconSize),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo(BuildContext context, Repository repository) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Primary Language', repository.language ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            onPressed: () => ref.invalidate(repositoryDetailControllerProvider),
          ),
        ],
      ),
    );
  }
}
