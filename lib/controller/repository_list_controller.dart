import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_repository_search/controller/search_notifier.dart';
import '../model/repository.dart';

final repositoryListControllerProvider = StateNotifierProvider<
    RepositoryListController, AsyncValue<List<Repository>>>(
  (ref) => RepositoryListController(ref: ref),
);

class RepositoryListController
    extends StateNotifier<AsyncValue<List<Repository>>> {
  final Ref ref;
  RepositoryListController({required this.ref})
      : super(const AsyncValue.data([]));

  /// 検索キーワードから GitHub API を呼び出してリポジトリ一覧を取得し、状態を更新する
  Future<void> searchRepositories(String query) async {
    state = const AsyncValue.loading();
    try {
      final repos =
          await ref.read(githubServiceProvider).searchRepositories(query);
      state = AsyncValue.data(repos);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
