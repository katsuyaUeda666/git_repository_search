import 'package:flutter/material.dart';
import 'package:git_repository_search/model/repository.dart';

class RepositoryCard extends StatelessWidget {
  final Repository repository;

  const RepositoryCard({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(repository.ownerAvatarUrl),
        ),
        title: Text(repository.name),
        subtitle: Text(repository.language ?? '言語情報なし'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // スター数の表示
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(repository.stargazersCount.toString()),
              ],
            ),
            const SizedBox(height: 4),
            // フォーク数の表示
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.call_split, size: 16),
                const SizedBox(width: 4),
                Text(repository.forksCount.toString()),
              ],
            ),
          ],
        ),
        onTap: () {
          // ここでリポジトリ詳細ページへの遷移処理などを追加できます
        },
      ),
    );
  }
}
