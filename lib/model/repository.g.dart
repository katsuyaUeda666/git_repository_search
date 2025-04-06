// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepositoryImpl _$$RepositoryImplFromJson(Map<String, dynamic> json) =>
    _$RepositoryImpl(
      name: json['name'] as String,
      language: json['language'] as String?,
      stargazersCount: (json['stargazers_count'] as num?)?.toInt(),
      watchersCount: (json['subscribers_count'] as num?)?.toInt(),
      forksCount: (json['forks_count'] as num?)?.toInt(),
      openIssuesCount: (json['open_issues_count'] as num?)?.toInt(),
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RepositoryImplToJson(_$RepositoryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'language': instance.language,
      'stargazers_count': instance.stargazersCount,
      'subscribers_count': instance.watchersCount,
      'forks_count': instance.forksCount,
      'open_issues_count': instance.openIssuesCount,
      'owner': instance.owner,
    };

_$OwnerImpl _$$OwnerImplFromJson(Map<String, dynamic> json) => _$OwnerImpl(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$OwnerImplToJson(_$OwnerImpl instance) =>
    <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
    };
