import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:git_repository_search/model/repository.dart';
import 'package:git_repository_search/controller/search_notifier.dart';

/// GitHubリポジトリ詳細取得用のProvider
final repositoryDetailControllerProvider =
    FutureProvider.family<Repository, (String, String)>((ref, params) async {
  final githubService =
      ref.read(githubServiceProvider); // search_notifier.dart の Provider を利用
  final (owner, repo) = params;

  try {
    // GitHubサービスを利用してリポジトリ詳細を取得
    return await githubService.fetchRepositoryDetail(owner, repo);
  } on DioException catch (e) {
    throw Exception('Dio Error: ${e.message}');
  } catch (e) {
    throw Exception('Unexpected Error: ${e.toString()}');
  }
});
