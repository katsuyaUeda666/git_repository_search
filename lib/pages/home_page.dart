import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_repository_search/controller/home_controller.dart';
import 'package:git_repository_search/widget/search_inputform.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // TextEditingController を State 内で保持
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // HomeController を Riverpod Provider から取得
    final homeController = ref.read(homeControllerProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 縦方向に中央配置
          children: [
            const Text('GitHub Search'),
            const SizedBox(height: 20),
            SearchInputForm(
              controller: _searchController,
              onChanged: (value) {},
              onSubmitted: (value) {
                // HomeController の onSearchSubmitted を呼び出して遷移
                homeController.onSearchSubmitted(value, context);
              },
              hintText: 'Search for repositories...',
            ),
          ],
        ),
      ),
    );
  }
}
