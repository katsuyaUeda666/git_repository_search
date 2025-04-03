import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_repository_search/pages/home_page.dart';
import 'package:git_repository_search/pages/repository_detail_page.dart';
import 'package:git_repository_search/pages/repository_list_page.dart';
import 'package:go_router/go_router.dart';

/// GoRouter のルート設定
final GoRouter router = GoRouter(
  routes: [
    /// ホームページ
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => _buildPage(state, const HomePage()),
    ),

    /// 検索結果一覧画面
    GoRoute(
      path: '/search',
      name: 'search',
      pageBuilder: (context, state) {
        final query = state.extra as String?;
        return _buildPage(state, RepositoryListPage(query: query ?? ''));
      },
    ),

    /// リポジトリ詳細画面
    GoRoute(
      path: '/detail/:owner/:repo',
      name: 'detail',
      pageBuilder: (context, state) {
        return _buildPage(state, RepositoryDetailPage());
      },
    ),
  ],
);

/// ページ生成ヘルパー
///
/// Android も含め、CupertinoPage を使うことでスワイプバック（iOS/Android両方）で戻れるように設定しています。
Page<dynamic> _buildPage(GoRouterState state, Widget child) {
  return CupertinoPage(
    key: state.pageKey,
    child: child,
  );
}
