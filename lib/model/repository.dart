import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@freezed
class Repository with _$Repository {
  factory Repository({
    required String name,
    @JsonKey(name: 'language') String? language,
    @JsonKey(name: 'stargazers_count') required int? stargazersCount,
    @JsonKey(name: 'subscribers_count') required int? watchersCount,
    @JsonKey(name: 'forks_count') required int? forksCount,
    @JsonKey(name: 'open_issues_count') required int? openIssuesCount,
    @JsonKey(name: 'owner') required Owner owner,
  }) = _Repository;

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);
}

@freezed
class Owner with _$Owner {
  factory Owner({
    required String login,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
