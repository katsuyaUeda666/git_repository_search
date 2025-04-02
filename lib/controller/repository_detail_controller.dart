import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_repository_search/controller/search_notifier.dart';
import '../model/repository.dart';

final repositoryDetailControllerProvider =
    FutureProvider.family<Repository, Map<String, String>>((ref, params) async {
  final githubService = ref.read(githubServiceProvider);
  final owner = params['owner']!;
  final repo = params['repo']!;
  final repository = await githubService.fetchRepositoryDetail(owner, repo);
  return repository;
});
