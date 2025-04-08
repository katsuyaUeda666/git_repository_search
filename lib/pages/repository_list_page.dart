import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_repository_search/controller/repository_list_controller.dart';
import 'package:git_repository_search/model/repository.dart';
import 'package:git_repository_search/widget/repository_card.dart';
import 'package:go_router/go_router.dart';

class RepositoryListPage extends ConsumerStatefulWidget {
  final String query;

  const RepositoryListPage({Key? key, required this.query}) : super(key: key);

  @override
  _RepositoryListPageState createState() => _RepositoryListPageState();
}

class _RepositoryListPageState extends ConsumerState<RepositoryListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(repositoryListControllerProvider.notifier)
          .searchRepositories(widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(repositoryListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          tooltip: '戻る',
        ),
        title: const Text('GitHub Search'),
      ),
      body: searchState.when(
        data: (repositories) => _buildRepositoryList(repositories),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorUI(error, stack),
      ),
    );
  }

  Widget _buildRepositoryList(List<Repository> repositories) {
    if (repositories.isEmpty) {
      return const Center(
        child: Text(
          '該当するリポジトリが見つかりません',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero, // リスト全体の余白をなくす
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        final repository = repositories[index];
        return RepositoryCard(
          repository: repository,
          onTap: () => _navigateToDetail(context, repository),
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, Repository repository) {
    final owner = repository.owner.login;
    final repoName = repository.name;

    if (owner == null || repoName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('リポジトリ情報が不正です')),
      );
      return;
    }

    context.pushNamed(
      'detail',
      pathParameters: {
        'owner': owner,
        'repo': repoName,
      },
    );
  }

  Widget _buildErrorUI(Object error, StackTrace stack) {
    debugPrintStack(stackTrace: stack, label: error.toString());

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 50),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              _parseError(error),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('再試行'),
            onPressed: () => ref.invalidate(repositoryListControllerProvider),
          ),
        ],
      ),
    );
  }

  String _parseError(dynamic error) {
    if (error.toString().contains('404')) return 'リポジトリが見つかりません';
    if (error.toString().contains('403')) return 'API制限に達しました';
    return 'エラーが発生しました: ${error.toString()}';
  }
}
