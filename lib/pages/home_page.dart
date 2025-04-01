import 'package:flutter/material.dart';
import 'package:git_repository_search/widget/search_inputform.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 縦方向に中央配置
          children: [
            const Text('GitHub Search'),
            const SizedBox(height: 20),
            SearchInputForm(
              controller: TextEditingController(),
              onChanged: (value) {
                // 検索入力の変更処理
              },
              onSubmitted: (value) {
                // 検索送信時の処理
              },
              hintText: 'Search for repositories...',
            ),
          ],
        ),
      ),
    );
  }
}
