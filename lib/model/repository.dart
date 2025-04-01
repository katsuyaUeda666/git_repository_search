import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

// ネストした JSON からオーナーのアバター URL を取り出すための関数
String _ownerAvatarUrlFromJson(Map<String, dynamic> ownerJson) =>
    ownerJson['avatar_url'] as String;

@freezed
class Repository with _$Repository {
  factory Repository({
    required String name,
    @JsonKey(name: 'owner', fromJson: _ownerAvatarUrlFromJson)
    required String ownerAvatarUrl,
    String? language,
    @JsonKey(name: 'stargazers_count') required int stargazersCount,
    @JsonKey(name: 'watchers_count') required int watchersCount,
    @JsonKey(name: 'forks_count') required int forksCount,
    @JsonKey(name: 'open_issues_count') required int openIssuesCount,
  }) = _Repository;

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);
}
