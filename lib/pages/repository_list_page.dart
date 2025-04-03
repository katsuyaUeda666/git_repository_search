import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_repository_search/controller/repository_list_controller.dart';
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
    // ページ表示後に検索処理をトリガーする
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
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        title: const Text('GitHub Search'),
      ),
      body: searchState.when(
        data: (repositories) {
          if (repositories.isEmpty) {
            return const Center(child: Text('No repositories found.'));
          }
          return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              final repository = repositories[index];
              return RepositoryCard(repository: repository);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
