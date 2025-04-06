import 'package:dio/dio.dart';
import 'package:git_repository_search/model/repository.dart';

class GithubService {
  final Dio _dio;

  GithubService({Dio? dio}) : _dio = dio ?? Dio();

  /// GitHubのリポジトリを検索する
  /// [query] で検索キーワードを指定し、結果としてRepositoryのリストを返す
  Future<List<Repository>> searchRepositories(String query) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/search/repositories',
        queryParameters: {'q': query},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final items = data['items'] as List<dynamic>;

        // JSONからRepositoryオブジェクトへ変換
        return items
            .map((item) => Repository.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load repositories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching repositories: $e');
    }
  }

  /// 指定されたオーナーとリポジトリ名に対して詳細情報を取得する
  Future<Repository> fetchRepositoryDetail(String owner, String repo) async {
    final response = await _dio.get(
      'https://api.github.com/repos/$owner/$repo',
      options: Options(headers: {'Accept': 'application/vnd.github.v3+json'}),
    );

    if (response.statusCode == 200) {
      return Repository.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch repository details');
    }
  }
}
