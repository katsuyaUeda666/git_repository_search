import 'package:git_repository_search/model/repository.dart';
import 'package:git_repository_search/service/github_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_notifier.g.dart';

/// GitHub API 呼び出し用の Provider
final githubServiceProvider = Provider<GithubService>((ref) => GithubService());

@Riverpod(keepAlive: true)
class SearchNotifier extends _$SearchNotifier {
  @override
  Future<List<Repository>> build() async {
    // 初期状態は空のリスト
    return [];
  }

  /// 検索キーワードからリポジトリを検索する
  Future<void> searchRepositories(String query) async {
    // ローディング状態に切り替え
    state = const AsyncValue.loading();
    try {
      final repos =
          await ref.read(githubServiceProvider).searchRepositories(query);
      // 正常終了時はデータをセット
      state = AsyncValue.data(repos);
    } catch (error, stackTrace) {
      // エラー発生時はエラー状態をセット
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
