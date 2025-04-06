import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_repository_search/pages/home_page.dart';
import 'package:git_repository_search/pages/repository_detail_page.dart';
import 'package:git_repository_search/pages/repository_list_page.dart';
import 'package:go_router/go_router.dart';

/// GoRouter のルート設定
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => _buildPage(state, const HomePage()),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      pageBuilder: (context, state) {
        final query = state.uri.queryParameters['q'] ?? '';
        return _buildPage(state, RepositoryListPage(query: query));
      },
    ),
    GoRoute(
      name: 'detail',
      path: '/detail/:owner/:repo',
      pageBuilder: (context, state) {
        final owner = state.pathParameters['owner']!;
        final repo = state.pathParameters['repo']!;
        return _buildPage(
            state, RepositoryDetailPage(owner: owner, repo: repo));
      },
    ),
  ],
);

Page<dynamic> _buildPage(GoRouterState state, Widget child) {
  return CupertinoPage(
    key: state.pageKey,
    child: child,
  );
}
