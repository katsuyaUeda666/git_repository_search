import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider =
    Provider<HomeController>((ref) => HomeController());

class HomeController {
  /// ホームページの検索ボックスでキーワードが送信されたときの処理
  /// GoRouter を使って検索結果ページへ遷移します
  void onSearchSubmitted(String query, BuildContext context) {
    if (query.isNotEmpty) {
      // ルーターで /search に遷移、extra に検索キーワードを渡す例
      context.go('/search', extra: query);
    }
  }
}
